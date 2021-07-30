-- create RECT Structure that have 4 long or int fields
local Struct = Memory.CreateStructure("int, int, int, int")

DLL.CallFunction("user32.dll", "GetWindowRect", Application.GetWndHandle()..",".. Struct, DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL);

local rc={}

rc.left = Memory.GetStructureData(Struct, 1)
rc.top = Memory.GetStructureData(Struct, 2)
rc.right = Memory.GetStructureData(Struct, 3)
rc.bottom = Memory.GetStructureData(Struct, 4)

strText="Left:"..rc.left.."\r\n"
strText=strText.."Top:"..rc.top.."\r\n"
strText=strText.."Right:"..rc.right.."\r\n"
strText=strText.."Bottom:"..rc.bottom.."\r\n"

result = Dialog.Message("Notice", strText, MB_OK, MB_ICONINFORMATION, MB_DEFBUTTON1);

Memory.FreeStructure(Struct)