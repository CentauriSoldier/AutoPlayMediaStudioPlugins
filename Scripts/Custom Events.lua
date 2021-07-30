--[[*******=*******->
     ExecuteEvent
<-****************]]
--[[
This can contain as many ghost variables (vVarx) as needed.
They will be used only if they exist in the calling function.
]]
local function ExecuteEvent(fEvent, vVar_1, vVar_2, vVar_3, vVar_4, vVar_5)

if type(fEvent) == "function" then
fEvent(vVar_1, vVar_2, vVar_3, vVar_4, vVar_5);
end
	
end

--Some Function Firing the Event
function SomeFunction()
--do something then...
ExecuteEvent(MyClass_OnDelete, sString, tTable, vEtc);
end

--the event function
function MyClass_OnDelete(sString, tTable, vEtc)
--do stuff with the passed variables
end











--HERE'S ANOTHER WAY TO DO IT TOO
--TEST----------------------------------------------------!!!
local Page_DeleteObject = Page.DeleteObject;

function Page.DeleteObject(sObject)

if type(Object_OnDelete) == "function" then
Object_OnDelete(sObject);
end

Page_DeleteObject(sObject)
end
--TEST----------------------------------------------------!!!

function Object_OnDelete(sObject)
Dialog.Message("Notice!", "Someone deleted the object called \""..sObject.."\".");
end
