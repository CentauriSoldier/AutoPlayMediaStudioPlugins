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
local ERROR_PLUGIN_NAME = "Log";
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
Log = {};
local LOG_FILES = {};
local ACTIVE_LOG = "";
local DISPLAY_ERRORS = false;
local LAST_LOG = "";
--Error.LogLastAppError

--[[
Version History

Version 1.0.0.0
Absorbed the Error Action Plugin
Updated the IRLua Plugin Helper Functions v2.9
]]


--[[
Return Codes
]]

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- BEGIN || Hidden Functions
function Error.SetError(sErrorType, sMessage)
ERROR_LAST_ERROR = "["..sErrorType.."]".."\r\n"..System.GetDate(DATE_FMT_US).."@"..System.GetTime(TIME_FMT_MIL).."="..sMessage;
end

function Error.GetLastError()
return ERROR_LAST_ERROR
end
-- END || Hidden Functions
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



--==============================
-- Log.Assign
--==============================
function Log.Assign(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sFilename = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sRet = "";
	
	if not File.DoesExist(sFilename) then
	TextFile.WriteFromString(sFilename, "", false);
	local nErr = Application.GetLastError();
		
		if nErr > 0 then
			
			if DISPLAY_ERRORS then
			return nErr
			--ERROR("Log.Assign", "Log file \""..sLogName.."\" using filename\r\n\""..sFilename.."\" could not be created.");
			end
			
		else
		ERROR_LOG_FILES[sLogName] = sFilename;
		sRet = sLogName;
		end
	
	end

return sRet
end



--==============================
-- Log.Clear
--==============================
function Log.Clear(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sLog = ERROR_LOG_FILES[sLogName];
local nRet = -1;

	if not sLog then
	nRet = 1;
	
		if DISPLAY_ERRORS then
		ERROR("Log.Clear", "File Error:\r\n".."Log file \""..sLogName.."\" has not been assigned using \"Log.Assign()\" function.\r\nNo log to clear.", 0);
		end
		
	else
	TextFile.WriteFromString(sLog, "", false);
		
		if Application.GetLastError() > 0 then
		nRet = 2;
		
			if DISPLAY_ERRORS then
			--ERROR
			end
		
		else	
		nRet = 0;
		end
		
	end

return nRet
end





--==============================
-- Log.Delete
--==============================
function Log.Delete(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sLog = LOG_FILES[sLogName];

	if not sLog then
		
		if DISPLAY_ERRORS then
		ERROR("Log.Delete", "File Error:\r\n".."Log file \""..sLogName.."\" has not been assigned using \"Log.SetActive()\" function.\r\nNo log to delete.", 0);
		end
		
	else
	File.Delete(sLog, false, false, true, nil);
	end


end



--==============================
-- Error.Display
--==============================
function Error.Display(...)
IRLUA_PLUGIN_CheckNumArgs(arg,4);
local sErrorType = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sMessage = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local nIconType = IRLUA_PLUGIN_CheckTypes(arg,3,{"number"});
local bAbort = IRLUA_PLUGIN_CheckTypes(arg,4,{"boolean"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

if bAbort == true then
error(sErrorType.." Error\r\n\r\n"..sMessage, 3);
else
Dialog.Message(sErrorType.." Error", sMessage, MB_OK, nIconType, MB_DEFBUTTON1);
end

Error.SetError(sErrorType, sMessage);
end



--==============================
-- Error.EnumerateLog
--==============================
function Error.Enumerate(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sMethod = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local tParameters = IRLUA_PLUGIN_CheckTypes(arg,3,{"table"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sLog = ERROR_LOG_FILES[sLogName];

	if not sLog and DISPLAY_ERRORS then
	ERROR("Log.Enumerate", "File Error:\r\n".."Log file \""..sLogName.."\" has not been assigned using \"Log.SetActive()\" function.\r\nNo log to enumerate.", 0);
	end
	
local sMethod = String.Lower(sMethod);


if sMethod == "Appearance" then

elseif sMethod == "Type" then

elseif sMethod == "Date" then

elseif sMethod == "Time" then

elseif sMethod == "Date and Time" then

end

end



--==============================
-- Log.Write
--==============================
function Log.Write(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sEntryType = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local sMessage = IRLUA_PLUGIN_CheckTypes(arg,3,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sLog = ERROR_LOG_FILES[sLogName];

	if not sLog and DISPLAY_ERRORS then
	ERROR("Log.Write", "File Error:\r\n".."Log file \""..sLogName.."\" has not been assigned using \"Log.SetActive()\" function.", 0);			
	end
	
INIFile.SetValue(sLog, sEntryType, System.GetDate(DATE_FMT_US).."@"..System.GetTime(TIME_FMT_MIL), sMessage);
		
	if Application.GetLastError() > 0 and DISPLAY_ERRORS then
	ERROR("Log.Write", "File Error:\r\nCould not log "..sEntryType.." Error in log file "..sLogName.." using filename\r\n"..sLog, 0);
	end

Error.SetError(sErrorType, sMessage);
end



--==============================
-- Log.WriteAndDisplay
--==============================
function Log.WriteAndDisplay(...)
IRLUA_PLUGIN_CheckNumArgs(arg,5);
local sLogName = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sErrorType = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local sMessage = IRLUA_PLUGIN_CheckTypes(arg,3,{"string"});
local nIconType = IRLUA_PLUGIN_CheckTypes(arg,4,{"number"});
local bAbort = IRLUA_PLUGIN_CheckTypes(arg,5,{"boolean"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sLog = ERROR_LOG_FILES[sLogName];

	if not sLog and DISPLAY_ERRORS then
	ERROR("Error.LogAndDisplay", "File Error:\r\n".."Log file \""..sLogName.."\" has not been assigned using \"Error.SetLog()\" function.", 0);			
	end
	
INIFile.SetValue(sLog, sErrorType, System.GetDate(DATE_FMT_US).."@"..System.GetTime(TIME_FMT_MIL), sMessage);	
		
	if Application.GetLastError() > 0 and DISPLAY_ERRORS then
	ERROR("Error.LogAndDisplay", "File Error:\r\nCould not log "..sErrorType.." Error in log file "..sLogName.." using filename\r\n"..sLog, 0);
	end

if bAbort == true then
Dialog.Message(sErrorType.." Error", sMessage, MB_OK, nIconType, MB_DEFBUTTON1);
else
error(sErrorType.." Error\r\n\r\n"..sMessage, 3);
end

Error.SetError(sErrorType, sMessage);
end



--==============================
-- Error.Report
--==============================
function Error.Report(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3);
local sEmailAddress = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sGeneratorName = IRLUA_PLUGIN_CheckTypes(arg,2,{"string", "nil"});
local sSeparatorSymbol = IRLUA_PLUGIN_CheckTypes(arg,3,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sSig = "";

	if sGeneratorName then
	
	local sSepSym = "";
	local nSymbolLength = String.Length(sGeneratorName);
	
		for x = 1, (nSymbolLength + Math.Round((nSymbolLength * 4.8), 0)) do
		sSepSym = sSepSym..sSeparatorSymbol;
		end
	
	local sHead = "<br><br><br><br><br><br><br><b>"..sSepSym.."</b>";
	local sFoot = "<b>"..sSepSym.."</b>";
	sSig = Error.GetLastError()..sHead.."<br><i>Error Report Generated by "..sGeneratorName.."</i><br>"..sFoot;
	
	else
	sSig = Error.GetLastError()
	end




File.OpenEmail(sEmailAddress.."?subject=Error Report&body="..sSig, SW_SHOWNORMAL);
end