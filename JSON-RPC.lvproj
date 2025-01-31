<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="19008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="python" Type="Folder">
			<Item Name="__pycache__" Type="Folder">
				<Item Name="ExamplePythonModule.cpython-39.pyc" Type="Document" URL="../python/__pycache__/ExamplePythonModule.cpython-39.pyc"/>
				<Item Name="JSONModule.cpython-39.pyc" Type="Document" URL="../python/__pycache__/JSONModule.cpython-39.pyc"/>
				<Item Name="NumpyExampleModule.cpython-39.pyc" Type="Document" URL="../python/__pycache__/NumpyExampleModule.cpython-39.pyc"/>
			</Item>
			<Item Name="ExamplePythonModule.py" Type="Document" URL="../python/ExamplePythonModule.py"/>
			<Item Name="JSONModule.py" Type="Document" URL="../python/JSONModule.py"/>
			<Item Name="myPython.vi" Type="VI" URL="../python/myPython.vi"/>
			<Item Name="NumpyExampleModule.py" Type="Document" URL="../python/NumpyExampleModule.py"/>
		</Item>
		<Item Name="VIMs" Type="Folder">
			<Item Name="Create Response-myJSON.vim" Type="VI" URL="../VIM/Create Response-myJSON.vim"/>
			<Item Name="Parse Response-myJSON.vim" Type="VI" URL="../VIM/Parse Response-myJSON.vim"/>
			<Item Name="Create Response-PythonModule.vim" Type="VI" URL="../VIM/Create Response-PythonModule.vim"/>
			<Item Name="Parse Response-PythonModule.vim" Type="VI" URL="../VIM/Parse Response-PythonModule.vim"/>
			<Item Name="ROLFPython.vi" Type="VI" URL="../VIM/ROLFPython.vi"/>
		</Item>
		<Item Name="tests" Type="Folder">
			<Item Name="TEST-JSON-RPC--Cluster.ctl" Type="VI" URL="../tests/TEST-JSON-RPC--Cluster.ctl"/>
			<Item Name="JSONtext-test-results-20210421.vi" Type="VI" URL="../tests/JSONtext-test-results-20210421.vi"/>
			<Item Name="UNITTESTS.vi" Type="VI" URL="../tests/UNITTESTS.vi"/>
			<Item Name="UNITTEST-JSON-RPC.vi" Type="VI" URL="../tests/UNITTEST-JSON-RPC.vi"/>
			<Item Name="UNITTEST-JSON-RPC-cluster.vi" Type="VI" URL="../tests/UNITTEST-JSON-RPC-cluster.vi"/>
			<Item Name="UNITTEST-JSON-RPC-Flatten.vi" Type="VI" URL="../tests/UNITTEST-JSON-RPC-Flatten.vi"/>
			<Item Name="UNITTEST-JSON-RPC-speed.vi" Type="VI" URL="../tests/UNITTEST-JSON-RPC-speed.vi"/>
		</Item>
		<Item Name="build support" Type="Folder">
			<Item Name="JSON-RPC.vipb" Type="Document" URL="../build support/JSON-RPC.vipb"/>
			<Item Name="JSON-RPC.vipc" Type="Document" URL="../build support/JSON-RPC.vipc"/>
		</Item>
		<Item Name="examples" Type="Folder">
			<Item Name="JSONrpc-Example.vi" Type="VI" URL="../JSON-RPC/examples/JSONrpc-Example.vi"/>
			<Item Name="JSONrpc-Flatten-Example.vi" Type="VI" URL="../JSON-RPC/examples/JSONrpc-Flatten-Example.vi"/>
		</Item>
		<Item Name="JSON-RPC.lvlib" Type="Library" URL="../JSON-RPC/JSON-RPC.lvlib"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="High Resolution Relative Seconds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/High Resolution Relative Seconds.vi"/>
				<Item Name="MD5Checksum core.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/MD5Checksum.llb/MD5Checksum core.vi"/>
				<Item Name="MD5Checksum format message-digest.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/MD5Checksum.llb/MD5Checksum format message-digest.vi"/>
				<Item Name="MD5Checksum pad.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/MD5Checksum.llb/MD5Checksum pad.vi"/>
				<Item Name="MD5Checksum string.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/MD5Checksum.llb/MD5Checksum string.vi"/>
				<Item Name="NI_Data Type.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/Data Type/NI_Data Type.lvlib"/>
				<Item Name="System Directory Type.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/sysdir.llb/System Directory Type.ctl"/>
				<Item Name="Get System Directory.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/sysdir.llb/Get System Directory.vi"/>
				<Item Name="JSONtext LVClass Serializer.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/JDP Science/JSONtext/LVClass Serializer/JSONtext LVClass Serializer.lvclass"/>
				<Item Name="Random Number (Range).vi" Type="VI" URL="/&lt;vilib&gt;/numeric/Random Number (Range).vi"/>
				<Item Name="Random Number (Range) DBL.vi" Type="VI" URL="/&lt;vilib&gt;/numeric/Random Number (Range) DBL.vi"/>
				<Item Name="Random Number (Range) I64.vi" Type="VI" URL="/&lt;vilib&gt;/numeric/Random Number (Range) I64.vi"/>
				<Item Name="sub_Random U32.vi" Type="VI" URL="/&lt;vilib&gt;/numeric/sub_Random U32.vi"/>
				<Item Name="Random Number (Range) U64.vi" Type="VI" URL="/&lt;vilib&gt;/numeric/Random Number (Range) U64.vi"/>
				<Item Name="1D String Array to Delimited String.vi" Type="VI" URL="/&lt;vilib&gt;/AdvancedString/1D String Array to Delimited String.vi"/>
				<Item Name="Guid Generator.vi" Type="VI" URL="/&lt;vilib&gt;/National Instruments/GUID Generator/Guid Generator.vi"/>
				<Item Name="Shuffle 1D Array.vim" Type="VI" URL="/&lt;vilib&gt;/Array/Shuffle 1D Array.vim"/>
				<Item Name="Define Test.vi" Type="VI" URL="/&lt;vilib&gt;/addons/_JKI Toolkits/Caraya/classes/Test/Define Test.vi"/>
				<Item Name="Make JSON Object.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Make JSON Object.vi"/>
				<Item Name="JSON type.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/JSON type.vi"/>
				<Item Name="Variant to JSON Text.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Variant to JSON Text.vi"/>
				<Item Name="Format JSON Object.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/support/Format JSON Object.vi"/>
				<Item Name="To JSON Text.vim" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/To JSON Text.vim"/>
				<Item Name="Set Item.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Set Item.vi"/>
				<Item Name="Array of Variants to JSON Array.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Array of Variants to JSON Array.vi"/>
				<Item Name="Set Item (as LVtype).vim" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Set Item (as LVtype).vim"/>
				<Item Name="Make JSON Array.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Make JSON Array.vi"/>
				<Item Name="Format JSON Array Text.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/support/Format JSON Array Text.vi"/>
				<Item Name="Get Array Elements.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Get Array Elements.vi"/>
				<Item Name="Get all Object Items.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Get all Object Items.vi"/>
				<Item Name="Flatten JSON Object to JSONpath Array.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Flatten JSON Object to JSONpath Array.vi"/>
				<Item Name="From JSON Text.vim" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/From JSON Text.vim"/>
				<Item Name="JSON text to Variant.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/JSON text to Variant.vi"/>
				<Item Name="Find Item (as LVtype).vim" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Find Item (as LVtype).vim"/>
				<Item Name="Find Item.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Find Item.vi"/>
				<Item Name="Next JSON Value.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Next JSON Value.vi"/>
				<Item Name="String Subset.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/String Subset.vi"/>
				<Item Name="Advance past next JSON Value (inlined COPY).vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past next JSON Value (inlined COPY).vi"/>
				<Item Name="Advance past whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past whitespace.vi"/>
				<Item Name="Advance past String.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past String.vi"/>
				<Item Name="Advance past Number.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past Number.vi"/>
				<Item Name="Advance past Line Ending.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past Line Ending.vi"/>
				<Item Name="Parse Full Path or Item Name.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Parse Full Path or Item Name.vi"/>
				<Item Name="Advance past Array.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past Array.vi"/>
				<Item Name="Advance past Object.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Parsing/Advance past Object.vi"/>
				<Item Name="Error Cluster From Code.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/support/Error Cluster From Code.vi"/>
				<Item Name="Find Item Locations by Path.vi" Type="VI" URL="/&lt;vilib&gt;/JDP Science/JSONtext/Offset/Find Item Locations by Path.vi"/>
				<Item Name="Assert.vi" Type="VI" URL="/&lt;vilib&gt;/addons/_JKI Toolkits/Caraya/classes/Assert/Assert.vi"/>
				<Item Name="Assert Almost Equal_Float.vi" Type="VI" URL="/&lt;vilib&gt;/addons/_JKI Toolkits/Caraya/classes/Assert/Assert Almost Equal_Float.vi"/>
				<Item Name="Assert Equal Value_Variant.vi" Type="VI" URL="/&lt;vilib&gt;/addons/_JKI Toolkits/Caraya/classes/Assert/Assert Equal Value_Variant.vi"/>
				<Item Name="Assert Not Error.vi" Type="VI" URL="/&lt;vilib&gt;/addons/_JKI Toolkits/Caraya/classes/Assert/Assert Not Error.vi"/>
			</Item>
			<Item Name="user.lib" Type="Folder">
				<Item Name="Random Number Within Range__ogtk.vi" Type="VI" URL="/&lt;userlib&gt;/_OpenG.lib/numeric/numeric.llb/Random Number Within Range__ogtk.vi"/>
				<Item Name="Random Number Within Range - I32__ogtk.vi" Type="VI" URL="/&lt;userlib&gt;/_OpenG.lib/numeric/numeric.llb/Random Number Within Range - I32__ogtk.vi"/>
				<Item Name="Wait (ms)__ogtk.vi" Type="VI" URL="/&lt;userlib&gt;/_OpenG.lib/time/time.llb/Wait (ms)__ogtk.vi"/>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
