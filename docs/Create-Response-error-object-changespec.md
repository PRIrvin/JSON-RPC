# Change spec: Create Response sends instrument errors as a bare `null`

Issue: [PRIrvin/JSON-RPC#2](https://github.com/PRIrvin/JSON-RPC/issues/2)

Status: proposed. The VI edits below are written as steps for you to carry out in LabVIEW 2019. Everything under "Current behavior" was read from the VIs with lvkit on 2026-10-27 (develop at `6086bf8`, package 1.2.7.16).

## Summary

Any error whose code is outside the reserved JSON-RPC codes reaches the client as the bare literal `null`, with no `jsonrpc`/`error`/`id` envelope. That covers the Instrument Framework's 4001 "command not supported", 5402, DAQmx errors, and the rest. The cause is one case frame in `private/Create Error Object.vi`. The fix is to make that frame do what the reserved-code frames already do. The framework keeps its own code 4001 on the wire (it is not remapped to -32601).

## Current behavior

### Create Response.vi

`API/Create Response.vi` is a thin wrapper around `private/Create Response-JSONtext.vi`, which works like this:

- If `id` is `"-1"` (a notification), it returns `""` and passes `error in` through unchanged.
- Otherwise it switches on `error in`:
  - In the "No Error" frame it builds `{"jsonrpc":"2.0","result":...,"id":"<id>"}` with `Variant to JSONRPC result .vi` and `Make JSON Object.vi`.
  - In the "Error" frame it calls `Create Error Object.vi`, bundles `{jsonrpc: "2.0", error: <error>, id}` into a cluster, and serializes it with `To JSON Text`. The `error in` of `To JSON Text` is wired to `Create Error Object.vi`'s `error out`.

### Create Error Object.vi

This VI switches on `error in`. It is called only from `Create Response-JSONtext.vi` (confirmed with an lvkit caller query), so the fix touches one caller.

| Frame | `error` (the error object) | `error out` |
| --- | --- | --- |
| "No Error" | default (empty) | `error in` |
| "Error -32700, -32600" | `{code, message: source}` | no error |
| "Error -32603..-32601, -32099..-32000" | `{code, message: source}` | no error |
| "Error", default | default (empty) | `error in` (passed through) |

For a code like 4001, the default frame hands `To JSON Text` an empty object and a live error. `To JSON Text` does nothing when its error in is set. The serialized string is therefore the bare `null` that clients see (the Python client gets `None`), and `Create Response` returns the original error on `error out`.

On the server, RemoteControl.ZMQ `Send Message.vi` (REP/SERVER branch) runs `Create Response.vi`, clears its error with `Clear Errors.vi`, and sends whatever string came out. The server therefore raises no error, and the client gets `null`.

Warnings (status false, nonzero code) take the "No Error" frame in both VIs, so they are not affected today or by this change.

## Proposed change

The goal is for the `"Error", default` frame of `private/Create Error Object.vi` to do the same as the two reserved-code frames: build `{code, message: source}` on `error` and return `no error` on `error out`.

Edit steps, in LabVIEW 2019:

1. Open `JSON-RPC.lvproj`, then open `JSON-RPC/private/Create Error Object.vi` and go to its block diagram.
2. Show the case frame `"Error -32603..-32601, -32099..-32000"`. Select its Unbundle By Name (`code`, `source`) and Bundle nodes and copy them.
3. Show the `"Error", default` frame. Paste the copied nodes into it, or rebuild them:
   - Wire `error in (no error)` into an **Unbundle By Name** that returns `code` and `source`.
   - Wire a `no error` (Error--Cluster) constant into a **Bundle** whose `code` input takes `code` and whose `message` input takes `source`.
4. In that frame:
   - Wire the Bundle output to the `error` indicator's output tunnel.
   - Wire a `no error` constant to the `error out` output tunnel, replacing the pass-through of `error in`.
   - Leave the `"No Error"` frame as it is.
5. Optional, recommended: show `"Error -32700, -32600"`, right-click the case structure border and choose **Delete This Case**, then do the same for `"Error -32603..-32601, -32099..-32000"`.
6. Check that the run arrow is unbroken and that no output tunnel is set to "Use Default If Unwired" in a way that hides a missing wire.
7. Save the VI. It is already a LabVIEW 2019 VI, so a normal save keeps it in 2019.

Deleting the two reserved-code frames (step 5) is recommended: with all three error frames identical, a single default frame means a future reserved code cannot be left out by accident. If you'd rather keep the explicit frames as documentation, copying the logic into the default frame gives the same behavior.

Either way:

- No connector pane, typedef, or other VI changes.
- `Create Response-JSONtext.vi` is not touched.

After saving, I can re-read the VI with lvkit to confirm the frames match the intended logic before you build.

On the wire, a framework "command not supported" error becomes:

```json
{"jsonrpc":"2.0","error":{"code":4001,"message":"<error source text>"},"id":"1"}
```

JSON-RPC 2.0 reserves -32768..-32000 for the protocol and leaves every other integer to the application, so 4001, 5402, and the negative DAQmx codes (-200xxx, all below -32768) are legal error codes. One side effect: codes inside the reserved block that the frames do not list (for example -32100) would now also be sent instead of becoming `null`. That is better than `null`, and nothing in the Levylab stack is known to produce them.

`message` is the LabVIEW `source` string, taken verbatim as the reserved-code frames already do. A LabVIEW source string may carry a call chain or `<APPEND>` text. Trimming it is not part of this change.

Out of scope: the alternative serializers under `VIM/` (`Create Response-myJSON.vim`, `Create Response-PythonModule.vim`) were not checked and are not changed.

## Client-side effect: Parse Response.vi

`private/Parse Response-JSONtext.vi` loops over the reply's top-level keys:

- `result` is kept as a JSON string.
- `id` is parsed as a string.
- `jsonrpc` other than `"2.0"` raises -32600 "Invalid Request".
- `error` is read as `Error--Cluster` (`code`, `message`) and turned into a LabVIEW error with `Error Cluster From Error Code.vi`.

The per-key errors are merged onto `error out`, and `result` stays `""` when the reply carries an error.

After the fix, a LabVIEW client (RemoteControl.ZMQ `Read Message.vi`, REQ/CLIENT branch, which calls `Parse Response.vi` and passes its error out) gets `error out` with code 4001 and the message text. Today the same call reportedly returns an empty result with no error, because a bare `null` has no keys to loop over.

This is the intended behavior change. Any client code that calls commands an instrument does not support, and today silently gets an empty result, will start getting errors. Python clients will get an `error` member instead of `None`. Check client scripts and the Python client's response handling before rolling the change out to the lab.

## Release path

- **This repo.** The VIPM package is `prirvin_lib_json_rpc`, installed to vi.lib `PRIrvin/JSON-RPC`. The remote is `PRIrvin/JSON-RPC` (fetch `JSON-RPC.git`, push `JSONrpc.git`). The latest build is 1.2.7.16, and the `.vipb` is already at 1.2.7.17 for the next build. The wire behavior changes, so release this as **1.2.8**. Follow the usual flow: commit on `develop`, merge to `main`, tag, build `builds/Package/prirvin_lib_json_rpc-1.2.8.x.vip`.
- **Instrument Type** (Instrument-Framework `build support/Instrument Type.vipb`) depends on `prirvin_lib_json_rpc >= 1.2.7.16`.
- **RemoteControl.ZMQ** (`build support/RemoteControl.ZMQ.vipb`, 1.5.4.38) depends on `prirvin_lib_json_rpc >= 1.2.6.15`.
- Both of those are floors, so 1.2.8 satisfies them without rebuilding either package. Recommended anyway: raise RemoteControl.ZMQ's floor to 1.2.8 at its next release, so a fresh install cannot pull in the old behavior.
- **Multichannel-Lockin** `build support/ApplyMe_2.23.0.vipc` pins `prirvin_lib_json_rpc-1.2.6.15` exactly. Regenerate it with 1.2.8. The KH7008 `.vipc` does not list JSON-RPC directly; it gets it through the framework packages.
- **Built applications** (lock-in, KH7008, Transport Server executables) contain a compiled copy of vi.lib. Each one must be rebuilt after 1.2.8 is installed on the build machine. Instruments run from source pick up the fix as soon as the package is installed.

## Test plan

Unit tests in this repo, LabVIEW 2019. For you to build: create `tests/UNITTEST-JSON-RPC-error-object.vi`, modeled on the existing `tests/UNITTEST-JSON-RPC-*.vi` tests, and add a call to it in `tests/UNITTESTS.vi`. It should cover cases 1-6 below.

1. `Create Response.vi` with `id` `"1"` and error code 4001, source `"command not supported"`, returns exactly `{"jsonrpc":"2.0","error":{"code":4001,"message":"command not supported"},"id":"1"}` with `error out` clear.
2. The same check for 5402, a DAQmx code (-200279), and -32100.
3. Regression: -32700, -32600, -32601, -32602, -32603, and -32000 produce the same output as before the change.
4. No error gives the same result reply as today. A warning (status false, code 4001) gives a result reply, not an error reply.
5. `id` `"-1"` with an error still returns `""` (notification behavior unchanged).
6. Round trip: `Create Response` with 4001, then `Parse Response`, gives `error out` code 4001, the message in `source`, and `result` `""`.
7. Run the existing `tests/UNITTESTS.vi` suite with no new failures.

Integration, after installing the package and running the simulated lock-in from source:

8. From Python over ZMQ REQ, send a well-formed JSON-RPC request with an unknown method. Expect the full envelope with code 4001. Then send `ACK` and expect a normal reply.
9. From a LabVIEW RemoteControl.ZMQ client, send an unknown command. Expect `error out` 4001, and expect the client to keep working afterwards.

Never send a malformed (non-JSON) request to a running instrument while testing this. See the next section.

## Related, not designed here: a non-JSON request gets no reply

Sending a non-JSON request leaves the server's ZMQ REP socket stuck. Observed on 2026-10-26: the simulated lock-in and the KH7008 stopped answering everything, including `ACK`, until they were restarted. JSON-RPC 2.0 says the reply should be -32700 Parse error with `"id": null`. Here is where the request is lost, as traced with lvkit:

1. **Read Message.vi (RemoteControl.ZMQ, REP/SERVER branch).** It passes the received frame to `Parse Request.vi` and returns `Parse Request`'s error as its own `error out`, along with whatever `Command` and `ID` the failed parse produced.
2. **Parse Request-JSONtext.vi (this repo).** `id` starts at `"-1"`. The VI never maps a JSONtext parse failure to -32700, even though `API/JSON-RPC Errors.vi` already defines -32700 "Parse error". The only error code it sets itself is -32600, for a wrong `jsonrpc` version. Not verified: whether JSONtext's `Get all Object Items.vi` raises an error on non-JSON input or just returns no items. Either way, the result is an empty command with id `"-1"`.
3. **Process.vi, "RC: Read Messages" state (RemoteControl).** The empty-command message is not passed to the instrument. The error goes into the JKI state machine's error handling, which for a Server queues `Macro: RC Exit` and `Macro: RC Initialize`. `Send Message.vi` is never called for this request, so the REP socket is never answered. Why the RC Exit/Initialize cycle does not recover the socket is not established.
4. **Even if the request reached `Send Message.vi`,** `Create Response` returns `""` for id `"-1"`. The best case would be an empty frame, not a -32700 reply.

The fix belongs mainly in **RemoteControl.ZMQ `Read Message.vi`**. Keeping the REP request/reply lockstep is that class's job. When `Parse Request` fails in the REP branch, the VI should send an error reply itself (`Create Response` with the error, then a ZMQ send) and return no error and no message, so `Process.vi` never holds an unanswered request. The same applies to a valid JSON notification (no `id`) arriving on a REP socket, which still has to be answered with something.

Supporting changes would go in **this repo**:

- `Parse Request` should report a parse failure as -32700 "Parse error".
- `Create Response` needs a way to send `"id": null` when the id is unknown. Today the id is always sent as a quoted string, and `"-1"` suppresses the reply entirely. One option: when the error is -32700 or -32600 and `id` is `"-1"`, send `"id": null` instead of returning `""`.

Both repos would need a release. This is a separate task from the change above.
