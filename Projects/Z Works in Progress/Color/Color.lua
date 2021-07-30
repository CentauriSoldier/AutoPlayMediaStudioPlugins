--#########################################################################################################
-- IRLUA PLUGIN HELPER FUNCTIONS By MicroByte (Revised by Centauri Soldier) ||@#$|| VERSION 2.7 ||$#@|| 
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
		elseif vInout == 1 then
		return true
		end
	
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
	end

elseif sNewType == "number" then
	
	if sOldType == "boolean" then
	
		if vInput == true then
		return 1
		elseif vInput == false then
		return 0
		end
	
	elseif sOldType == "string" then
	
	return tonumber(vInput);				
				
	end

end
end
--#########################################################################################################
--ERROR PLUGIN DETAILS
local ERROR_PLUGIN_NAME = "Color";
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
--Throws and error if the required plugin is not loaded
local REQUIRE = function(tPlugin,sPluginName)
if not tPlugin then
local sWebText = "";
IRLUA_PLUGIN_ERROR("\r\nError loading the \""..ERROR_PLUGIN_NAME.."\" plugin.\r\nThis plugin requires the \""..sPluginName.."\" plugin.");
end
end
--#########################################################################################################
-- END IRLUA PLUGIN HELPER FUNCTIONS
--#########################################################################################################
Color = {};

--========================================|
-- Color.HexColorToRGB                      |
--========================================|
function Color.HexColorToRGB(...)
IRLUA_PLUGIN_CheckNumArgs(arg, 1);
local sHexColor = IRLUA_PLUGIN_CheckTypes(arg, 1, {"string"});
if String.Length(sHexColor) == 6 then
local tLetters = {"a", "b", "c", "d", "e", "f"};
local tStrings = {};
local tColors = {};
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
tStrings[1] = String.Lower(String.Left(sHexColor, 1));
tStrings[2] = String.Lower(String.Mid(sHexColor, 2, 1));
tStrings[3] = String.Lower(String.Mid(sHexColor, 3, 1));
tStrings[4] = String.Lower(String.Mid(sHexColor, 4, 1));
tStrings[5] = String.Lower(String.Mid(sHexColor, 5, 1));
tStrings[6] = String.Lower(String.Right(sHexColor, 1));

for nIndex, sHexValue in tStrings do

	for nLetterValue, sLetter in tLetters do
		
		if sHexValue == sLetter then
		tStrings[nIndex] = ""..(nLetterValue + 9).."";
		end
		
	end

end

tColors.Red = (String.ToNumber(tStrings[1]) * 16) + String.ToNumber(tStrings[2]);
tColors.Green = (String.ToNumber(tStrings[3]) * 16) + String.ToNumber(tStrings[4]);
tColors.Blue = (String.ToNumber(tStrings[5]) * 16) + String.ToNumber(tStrings[6]);

return tColors
else
return nil
end
end






--===========================
-- Color.DecimalColorToHex
--===========================
function Color.DecimalColorToHex()
IRLUA_PLUGIN_CheckNumArgs(arg, 1);
local nColor = IRLUA_PLUGIN_CheckTypes(arg, 1, {"number", "string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if type(nColor) == "string" then
nColor = String.ToNumber(nColor);
end

local sRet = MathEx.Base10ToBaseX(nColor, 16);

if String.Length(sRet) == 6 then
return sRet
else
return ""
end

end



--===========================
-- Color.DecimalColorToRGB
--===========================
function Color.DecimalColorToRGB(...)
IRLUA_PLUGIN_CheckNumArgs(arg, 1);
local nColor = IRLUA_PLUGIN_CheckTypes(arg, 1, {"number", "string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if type(nColor) == "string" then
nColor = String.ToNumber(nColor);
end

return MathEx.HexColorToRGB(MathEx.Base10ToBaseX(nColor, 16))
end



--========================================|
-- Color.HexColorToRGB                   |
--========================================|
function Color.HexColorToRGB(...)
IRLUA_PLUGIN_CheckNumArgs(arg, 1);
local sHexColor = IRLUA_PLUGIN_CheckTypes(arg, 1, {"string"});
if String.Length(sHexColor) == 6 then
local tLetters = {"a", "b", "c", "d", "e", "f"};
local tStrings = {};
local tColors = {};
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
tStrings[1] = String.Lower(String.Left(sHexColor, 1));
tStrings[2] = String.Lower(String.Mid(sHexColor, 2, 1));
tStrings[3] = String.Lower(String.Mid(sHexColor, 3, 1));
tStrings[4] = String.Lower(String.Mid(sHexColor, 4, 1));
tStrings[5] = String.Lower(String.Mid(sHexColor, 5, 1));
tStrings[6] = String.Lower(String.Right(sHexColor, 1));

for nIndex, sHexValue in tStrings do

	for nLetterValue, sLetter in tLetters do
		
		if sHexValue == sLetter then
		tStrings[nIndex] = ""..(nLetterValue + 9).."";
		end
		
	end

end

tColors.Red = (String.ToNumber(tStrings[1]) * 16) + String.ToNumber(tStrings[2]);
tColors.Green = (String.ToNumber(tStrings[3]) * 16) + String.ToNumber(tStrings[4]);
tColors.Blue = (String.ToNumber(tStrings[5]) * 16) + String.ToNumber(tStrings[6]);

return tColors
else
return nil
end
end



--========================================|
-- Color.RGBColorToHex                   |
--========================================|
function Color.RGBColorToHex(...)
IRLUA_PLUGIN_CheckNumArgs(arg, 1);
local tRGB = IRLUA_PLUGIN_CheckTypes(arg, 1, {"table"});
local bContinue = true;
local sHex = "";
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


if Table.Count(tRGB) ~= 3 then
bContinue = false;
end

if bContinue then 

	for nIndex, nColor in tRGB do
		
		if type(nColor) ~= "number" then
		bContinue = false;
		end
	
	end

end

if bContinue then
	
	for nIndex, nColor in tRGB do
	sHex = sHex..MathEx.Base10ToBaseX(nColor, 16);
	end
	
end

if bContinue then

	if String.Length(sHex) ~= 6 then
	sHex = "";
	end

end

return sHex
end




