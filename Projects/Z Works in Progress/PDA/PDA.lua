--#########################################################################################################
-- IRLUA PLUGIN HELPER FUNCTIONS By MicroByte (Revised by Centauri Soldier) ||@#$|| VERSION 2.9 ||$#@|| 
--#########################################################################################################
_ShowErrorEventContext=true-- set this to false to disable 'EventContext' display
--#########################################################################################################
local IRLUA_PLUGIN_ERROR = error;
--#########################################################################################################
-- Sets a Global error message in the runtime engine.
IRLUA_PLUGIN_SetGlobalErrorMessage = function(nCode, sMessage)
	if _tblErrorMessages[nCode] then
		if _ShowErrorEventContext then
			local sEventContext=Debug.GetEventContext()
			IRLUA_PLUGIN_ERROR("Error code "..nCode.." already in use, please use another.\r\n\r\nEventContext: "..sEventContext,2)
		else
			IRLUA_PLUGIN_ERROR("Error code "..nCode.." already in use, please use another.",2)
		end
	else
		_tblErrorMessages[nCode]=sMessage
	end
end
--#########################################################################################################
-- Checks the number of arguments in the table and throws a syntax error If there are Not enough. 
-- This is useful For checking the number of arguments available To your aciton.
local IRLUA_PLUGIN_CheckNumArgs = function(tbArgs,nArgs) 
	local nCount=table.getn(tbArgs)
	if nCount < nArgs then
		if _ShowErrorEventContext then
			local sEventContext=Debug.GetEventContext()
			IRLUA_PLUGIN_ERROR(nArgs.." Arguments expected, "..nCount.." Arguments passed.\r\n\r\nEventContext: "..sEventContext,3)
		else
			IRLUA_PLUGIN_ERROR(nArgs.." Arguments expected, "..nCount.." Arguments passed.",3)
		end
	end
end
--#########################################################################################################
-- Checks the value at a given argument table position To see if it is any of the specified types.
-- If Not it throws a syntax error.
--Possible variable types[ boolean, function, nil, number, string, table, thread, userdata]
local IRLUA_PLUGIN_CheckTypes = function(tbArgs,nArg,tTypes)
local sType = type(tbArgs[nArg]);
local nTotalTypes = Table.Count(tTypes);
local nStrikes = 0;
local sAllowedTypes = "";

for nIndex, sAllowedType in pairs(tTypes) do
	
	if nIndex < (nTotalTypes - 1) then
	sAllowedTypes = sAllowedTypes.." "..sAllowedType..",";
	elseif nIndex == nTotalTypes - 1 then
	sAllowedTypes = sAllowedTypes.." "..sAllowedType;
	elseif nIndex == nTotalTypes then
		if nTotalTypes == 1 then
		sAllowedTypes = " "..sAllowedType;
		else
		sAllowedTypes = sAllowedTypes.." or "..sAllowedType;
		end
	end
	
	if sType ~= String.Lower(sAllowedType) then
	nStrikes = nStrikes + 1;
	end
end

if nStrikes == nTotalTypes then
	if _ShowErrorEventContext then
	local sEventContext=Debug.GetEventContext()
	IRLUA_PLUGIN_ERROR("bad argument #" .. nArg .. ", must be a "..sAllowedTypes..", you passed a "..sType..".\r\n\r\nEventContext: "..sEventContext,3)
	else
	IRLUA_PLUGIN_ERROR("bad argument #" .. nArg .. ", must be a "..sAllowedTypes..", you passed a "..sType..".",3)
	end
else
return tbArgs[nArg]
end
end
--#########################################################################################################
-- Ensures that your table contains data of only the specified type. If it does not then false is returned.
-- This will see nil values as subtable declarations and will, therefore, ignore them.
local IRLUA_PLUGIN_CheckTableVars = function(tTable,tVarTypes)
local bRet = true;
local nTypes = Table.Count(tVarTypes);
local nStrikes = 0;

for nIndex, sItem in pairs(tTable) do
nStrikes = 0;

	for nType, sType in pairs(tVarTypes) do

		if type(sItem) ~= sType then
		nStrikes = nStrikes + 1;
		end
			
	end
	
	if nStrikes >= nTypes then
	bRet = false;
	break;
	end

end
return bRet
end
--#########################################################################################################
-- Converts certain datatypes into other datatypes ||| Supported Types |||
-- [String <-> Boolean] [Number <-> Boolean] [String <-> Number]
--#########################################################################################################
local CONVERT = function (vInput, sNewType)
local sOldType = type(vInput);

if sNewType == "boolean" then

	if sOldType == "string" then

		if String.Lower(vInput) == "true" then
		return true
		elseif String.Lower(vInput) == "false" then
		return false
		end
		
	elseif sOldType == "number" then
		
		if vInput == 0 then
		return false
		elseif vInput == 1 then
		return true
		end
	
	elseif sOldType == "table" then
	
		if vInput then
		return true
		else
		return false
		end
	
	else
	
	return false	
	end

elseif sNewType == "string"	then
	
	if sOldType == "boolean" then
	
		if vInput == true then
		return "true"
		elseif vInput == false then
		return "false"
		end
	
	elseif sOldType == "number" then
	return ""..vInput..""
	
	else
	
	return ""
	end

elseif sNewType == "number" then
	
	if sOldType == "boolean" then
	
		if vInput == true then
		return 1
		elseif vInput == false then
		return 0
		end
	
	elseif sOldType == "string" then
	
	return tonumber(vInput)				
	
	else
	
	return -1
	end

end
end
--#########################################################################################################
--ERROR PLUGIN DETAILS
local ERROR_PLUGIN_NAME = "PDA";
--#########################################################################################################
--Displays a custom error message using the plugin and function name and lists the event context as well.
local ERROR = function(sFunctionName,sMessage,nEmbedLevel)

if not nEmbedLevel then
nEmbedLevel = 0;
elseif type(nEmbedLevel) ~= "number" then
nEmbedLevel = 0;
end

if type(sFunctionName) ~= "string" then
sFunctionName = "";
end	

local sFunctionNameCode = "";
if String.Replace(sFunctionName, " ", "", false) ~= "" then
sFunctionNameCode = ", function \""..sFunctionName.."()\"";
end

IRLUA_PLUGIN_ERROR("\r\nError in \""..ERROR_PLUGIN_NAME.."\" plugin"..sFunctionNameCode.."\r\n\r\n"..sMessage.."\r\n\r\nEventContext: "..Debug.GetEventContext(),3 + nEmbedLevel);
end
--#########################################################################################################
--Throws and error if the required plugin is not loaded. This should be called at the called at the
--beginning of each function, once for each required plugin.
--NOTE: This may be called at once only at the start of your plugin script if the required plugin is after your plugin alphabetically
local REQUIRE = function(tPlugin,sPluginName)
if not tPlugin then
IRLUA_PLUGIN_ERROR("\r\nError loading the \""..ERROR_PLUGIN_NAME.."\" plugin.\r\nThis plugin requires the \""..sPluginName.."\" plugin.");
end
end
--#########################################################################################################
-- END IRLUA PLUGIN HELPER FUNCTIONS
--#########################################################################################################
PDA = {};

--[[Version History
Version 1.0.0.0
Integrated all disparate Page and DialogEx functions into one plugin
]]



local function Action()
if Application.GetCurrentDialog() ~= "" then
return DialogEx
else
return Page
end
end



--=========================
-- PDA.ClickObject
--=========================
function PDA.ClickObject(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().ClickObject(sObject);
end



--=========================
-- PDA.CreateObject
--=========================
function PDA.CreateObject(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local nType = IRLUA_PLUGIN_CheckTypes(1,{"number"});
local sObject = IRLUA_PLUGIN_CheckTypes(2,{"string"});
local tProps = IRLUA_PLUGIN_CheckTypes(3,{"table"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().CreateObject(nType, sObject, tProps);
end



--=========================
-- PDA.DeleteObject
--=========================
function PDA.DeleteObject(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().DeleteObject(sObject)
end



--=========================
-- PDA.EnumerateObjects
--=========================
function PDA.EnumerateObjects()
return Action().EnumerateObjects()
end



--=========================
-- PDA.GetCurrent
--=========================
function PDA.GetCurrent()
local sPage = Application.GetCurrentPage();
local sDialog = Application.GetCurrentDialog();

if sPage ~= "" then
return sPage
elseif sDialog ~= "" then
return sDialog
else
return ""
end

end



--=========================
-- PDA.GetFocus
--=========================
function PDA.GetFocus()
return Action().GetFocus();
end



--=========================
-- PDA.GetObjectScript
--=========================
function PDA.GetObjectScript(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local sEventName = IRLUA_PLUGIN_CheckTypes(2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().GetObjectScript(sObject, sEventName);
end



--=========================
-- PDA.GetObjectType
--=========================
function PDA.GetObjectType(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
return Action().GetObjectType(sObject)
end



--=========================
-- PDA.GetScript
--=========================
function PDA.GetScript(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sPageDialog = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local sEvent = IRLUA_PLUGIN_CheckTypes(2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
return Action().GetScript(sPageDialog, sEvent)
end



--=========================
-- PDA.GetRadioValue
--=========================
function PDA.GetRadioValue(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sGroupID = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local nType = IRLUA_PLUGIN_CheckTypes(2,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
return Action().GetRadioValue(sGroupID, nType);
end



--=========================
-- PDA.GetSize
--=========================
function PDA.GetSize()
return Action().GetSize()
end



--=========================
-- PDA.IsDialog
--=========================
function PDA.IsDialog()
if Application.GetCurrentDialog() ~= "" then
return true
end
return false
end



--=========================
-- PDA.IsPage
--=========================
function PDA.IsPage()
if Application.GetCurrentPage() ~= "" then
return true
end
return false
end



--=========================
-- PDA.Print
--=========================
function PDA.Print(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local bShowPrintDialog = IRLUA_PLUGIN_CheckTypes(1,{"boolean"});
local bScaleToFite = IRLUA_PLUGIN_CheckTypes(2,{"boolean"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().Print(bShowPrintDialog, bScaleToFite);
end



--=========================
-- PDA.Redraw
--=========================
function PDA.Redraw()
Action().Redraw();
end



--=========================
-- PDA.SetFocus
--=========================
function PDA.SetFocus(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().SetFocus(sObject);
end



--=========================
-- PDA.SetObjectScript
--=========================
function PDA.SetObjectScript(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local sEvent = IRLUA_PLUGIN_CheckTypes(2,{"string"});
local sScript = IRLUA_PLUGIN_CheckTypes(3,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().SetObjectScript(sObject, sEvent, sScript);
end



--=========================
-- PDA.SetObjectZOrder
--=========================
function PDA.SetObjectZOrder(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local sObject = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local nPos = IRLUA_PLUGIN_CheckTypes(2,{"number"});
local sObjectRef = IRLUA_PLUGIN_CheckTypes(3,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().SetObjectZOrder(sObject, nPos, sObjectRef);
end



--=========================
-- PDA.SetRadioValue
--=========================
function PDA.SetRadioValue(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local sValue = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local sGroupID = IRLUA_PLUGIN_CheckTypes(2,{"string"});
local nType = IRLUA_PLUGIN_CheckTypes(3,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().SetRadioValue(sValue, sGroupID, nType);
end



--=========================
-- PDA.SetScript
--=========================
function PDA.SetScript(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local sPageDialog = IRLUA_PLUGIN_CheckTypes(1,{"string"});
local sEvent = IRLUA_PLUGIN_CheckTypes(2,{"string"});
local sScript = IRLUA_PLUGIN_CheckTypes(3,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
return Action().GetScript(sPageDialog, sEvent, sScript)
end



--=========================
-- PDA.SetTimer
--=========================
function PDA.SetTimer(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local nInterval = IRLUA_PLUGIN_CheckTypes(1,{"number"});
local nID = IRLUA_PLUGIN_CheckTypes(2,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().StartTimer(nInterval, nID);
end



--=========================
-- PDA.StopTimer
--=========================
function PDA.StopTimer(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local nID = IRLUA_PLUGIN_CheckTypes(1,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Action().StopTimer(nID);
end