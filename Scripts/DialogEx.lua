--[[
This code is the combination of code By Shadiku (ShadowUK)
and Centauri Soldier; our Dialog.Ex(t) code merged.
]]
DialogEx_Show = DialogEx.Show;
DialogEx_Close = DialogEx.Close;

function DialogEx.Show(sDialogName, bParentCoordinates, nX, nY)
assert(type(sDialogName) == "string", Debug.GetEventContext().."\r\nArgument 1 must be of type string.");
	
if not (bParentCoordinates) then
bParentCoordinates = false;
end
	
local vRet = DialogEx_Show(sDialogName, bParentCoordinates, nX, nY);
	

local vRet = DialogEx_Return;
DialogEx_Return = nil;
return vRet;
end


function DialogEx.Close(vRet)
DialogEx_Return = vRet;
DialogEx_Close();
end