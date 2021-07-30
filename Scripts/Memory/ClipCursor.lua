--locks the cursor to an area of the screen
function ClipCurosr(TopLeft_X, TopLeft_Y, BottomRight_X, BottomRight_Y)
local cRECT = Memory.CreateStructure("long, long, long, long");

Memory.SetStructureData(cRECT, 1, 0, TopLeft_X);
Memory.SetStructureData(cRECT, 2, 0, TopLeft_Y);
Memory.SetStructureData(cRECT, 3, 0, BottomRight_X);
Memory.SetStructureData(cRECT, 4, 0, BottomRight_Y);

local vRet = DLL.CallFunction(_SystemFolder.."\\user32.dll", "ClipCursor", cRECT, DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL);

Memory.FreeStructure(cRECT);

return vRet
end