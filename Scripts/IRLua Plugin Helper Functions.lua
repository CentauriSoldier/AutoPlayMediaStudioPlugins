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
local ERROR_PLUGIN_NAME = "";
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
--Throws an error if the required plugin is not loaded. This should be called at the beginning of each
-- function, once for each required plugin.
--NOTE: This may be called at once only at the start of your plugin script if the required plugin is after your plugin alphabetically
local REQUIRE = function(tPlugin,sPluginName)
if not tPlugin then
IRLUA_PLUGIN_ERROR("\r\nError loading the \""..ERROR_PLUGIN_NAME.."\" plugin.\r\nThis plugin requires the \""..sPluginName.."\" plugin.");
end
end
--#########################################################################################################
-- END IRLUA PLUGIN HELPER FUNCTIONS
--#########################################################################################################


--[[
--Example Usage

function TEST(...)
-- this function requires 3 arguments of differenet types.
-- check the number of arguments
IRLUA_PLUGIN_CheckNumArgs(arg,3);

local junk1 = IRLUA_PLUGIN_CheckTypes(arg,1,{"string", "table"});
local junk2 = IRLUA_PLUGIN_CheckTypes(arg,2,{"number", "table"});
local junk3 = IRLUA_PLUGIN_CheckTypes(arg,3,{"nil", "number"});
Dialog.Message("Test", "Run Through");

local bRet = IRLUA_PLUGIN_CheckTableVars(junk1,{"string","number"});

if bRet then
Dailog.Message("Good", "Table data checks out");
elseif bRet == false then
Dailog.Message("Error", "Bad table data");
end

end




NOTES ON ERROR FUNCTION
add the following to each function...
local sCallingFunction = "MyFunction";
..where "MyFunction" is the name of the calling function.
NOTE: the sCallingFunction variable can be called whatever you like. It is argument number one for the ERROR function
EXAMPLE: ERROR(sCallingFunction, "The world cannot be saved by a plugin");

If the error is inside an embedded function (a function within a function) then use a number for the third agument.
The number is the depth of the ERROR message call (o for being inside one function, 1 for being inside a function within another function and so on).
If you are not calling the ERROR function from within an ebedded function then you do not need the third argument, it can be nil.


NOTES ON ERROR CODE IMPLEMENTATION
--EDIT: I forgot to mention, also make heavy use of Application.SetLastError in your actions, try and use predefined error codes but if you need to add error codes use IRLUA_PLUGIN_SetGlobalErrorMessage with a unique number range

--example ( if you run the below script the message will read "Some error message"
--Code:

IRLUA_PLUGIN_SetGlobalErrorMessage(0023114, "Some error message")
IRLUA_PLUGIN_SetGlobalErrorMessage(0023113, "Some other error message")

Application.SetLastError(0023114)


-- Test for error
error = Application.GetLastError();
if (error ~= 0) then
	Dialog.Message("Error", _tblErrorMessages[error], MB_OK, MB_ICONEXCLAMATION);
end
]]


--[[Version History
Version 2.0
Started tinkering with MicroByte's brainchild
Added the ERROR function

Version 2.1
Renamed and rewrote the IRLUA_PLUGIN_CheckString()[and other variable types] function to IRLUA_PLUGIN_CheckTypes

Version 2.2
Bugfix release

Version 2.3
Added the IRLUA_PLUGIN_CheckTableVars() function

Version 2.4
Fixed a bug that occured when AMS code overwrote the native lua error function

Version 2.5
Added the REQUIRE() function

Version 2.6
Updated to be compatible with AMS 8.0

Version 2.7
Added the CONVERT function

Version 2.8
Fixed an operational bug in the REQUIRE() function that caused it to fail if a plugin requirement came after the calling plugin alphabetically

Version 2.9
Fixed a typo in the CONVERT function
]]