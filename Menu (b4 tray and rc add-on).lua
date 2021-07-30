--#########################################################################################################
-- IRLUA PLUGIN HELPER FUNCTIONS By MicroByte (Revised by Centauri Soldier) ||@#$|| VERSION 2.8 ||$#@|| 
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
local ERROR_PLUGIN_NAME = "Menu";
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
Menu = {};
local MENU_ACTIVE = "";
local MENU_MENUS = {};
local MENU_DELIMITER = "|";
local MENU_USER_XML_BANK = "";
local MENU_CONTROL_CHAR = "µ";
local MENU_CODE = {};


--[[
Common Return Values:
-4 | File Error
-3 | No Active Menu
-2 | invalid menu construction
-1 | the menu does not exist
 0 | action succeeded
 1 | menu already exists
 2 | 
 3 | 
]]


--[[Version History
Version 3.0.0.0
Rewrote the plugin and framework from scratch(again)
List of all currently existing functions:
	Menu.Create()
	Menu.DoesExist()
	Menu.GetActive()
	Menu.GetChecked()
	Menu.GetEnabled()
	Menu.GetNames()
	Menu.GetItemProperties()
	Menu.GetTable()
	Menu.GetXML()
	Menu.OnMenu()
	Menu.RemoveItem()
	Menu.Rename()
	Menu.RenameItem()
	Menu.SetActive()
	Menu.SetChecked()
	Menu.SetEnabled()
	Menu.SetDelmiter()
	Menu.SetItem()
	Menu.ToggleChecked()
	Menu.ToggleEnabled()
	Menu.Update()

Version 3.1.0.0
Added the following functions:
	Menu.LoadFromFile()
	Menu.SaveToFile()
	Menu.SetXML()
	
Version 3.1.0.1
Fixed the Menu.OnMenu() easy action argument
Added the Menu.Enable() function

Version 3.1.0.2
Fixed a bug that disallowed the creation of more than one separator per main menu item

Version 3.2.0.0
Fixed a bug that caused menu saving and loading to fail
Fixed a bug in the Menu.SetDelmiter() function
Fixed a bug that disallowed spaces in menu names

Version 3.3.0.0
Fixed a typo in Menu.Enable() that disallowed its execution
Fixed a bug in Menu.SetItem() that enabled/disabled an entire menu when only one item was targeted
Fixed a bug in Menu.SaveToFile() that caused the saved menu table to be deleted from memory
Localized the common menu variables, increasing plugin performance

	Later
	Menu.MoveItem()
]]

--=============================================================>>>>>>>>>>>>
-- BEGIN | HIDDEN FUNCTIONS
---------------------------------------------------------------


--===========================
-- StringToXMLAtt
--===========================
local function StringToXMLAtt(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sInput = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local tChars = {"\n","\r","\r\n","\t","\"","<",">","="};
local sRet = sInput;

for nIndex, sChar in pairs(tChars) do
sRet = String.Replace(sRet, tChars[nIndex], "¬"..nIndex.."", false);
end

return sRet
end



--===========================
-- XMLAttToString
--===========================
local function XMLAttToString(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sInput = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local tChars = {"\n","\r","\r\n","\t","\"","<",">","="};
local sRet = sInput;

for nIndex, sChar in pairs(tChars) do
sRet = String.Replace(sRet, "¬"..nIndex.."", tChars[nIndex], false);
end

return sRet
end



--========================
-- DSTT
--========================
local function DSTT(DelimitedString, Delimiter)
	tbReturn = {};
	local strWorking;
	local nPos = nil;
	local strData;
	local nTableIndex = 1;
	local nDelimiterLength = String.Length(Delimiter);
	
	if(nDelimiterLength < 1)then
		tbReturn[nTableIndex] = DelimitedString;
		return tbReturn;
	end
	
	strWorking = DelimitedString;
	nPos = String.Find(strWorking,Delimiter);
	while(nPos ~= -1)do
		strData = String.Left(strWorking,nPos-1);
		tbReturn[nTableIndex] = strData;
		nTableIndex = nTableIndex + 1;
		local nLength = String.Length(strWorking);
		strWorking = String.Right(strWorking,nLength - (nPos + (nDelimiterLength-1)));
		nPos = String.Find(strWorking,Delimiter);
	end
	if(strWorking ~= "")then
		tbReturn[nTableIndex] = strWorking;
	end
	
	return tbReturn;
end



--========================
-- GetForamttedPath
--========================
local tControlChars = {
{"\"","quot"},
{"'","apos"},
{"&","amp"},
{"<","lt"},
{">","gt"},
{" ","-"},
};

function GetFormattedPath(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sPath = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
for nCID, tCC in pairs(tControlChars) do
sPath = String.Replace(sPath, tCC[1], tCC[2], false);
end

return sPath
end



--========================
-- MenuStringToXMLPath
--========================
local function MenuStringToXMLPath(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sItemPath = String.Replace(sMenuString, "|", "/", false);
sItemPath = String.Replace(sItemPath, "---", "SEPARATOR", false);
return "menu/"..sItemPath
end



--========================
-- RestoreXML
--========================
local function RestoreXML()
if MENU_USER_XML_BANK ~= "" then
XML.SetXML(MENU_USER_XML_BANK);
end

MENU_USER_XML_BANK = "";
end



--========================
-- StoreXML
--========================
local function StoreXML(sMenu)
local sXML = XML.GetXML();

if sXML ~= "" then
MENU_USER_XML_BANK = sXML;
end

XML.SetXML(MENU_MENUS[sMenu]);
end



local function ParseXMLToMenu(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.DoesExist(sMenu) then
local tMenu = {};
--===============================================================<<<<<<<
local function GetAtts(sXMLPath)
local tRet = {
[1] = {ID=tonumber(XML.GetAttribute(sXMLPath, "id")),Text=XML.GetAttribute(sXMLPath, "text"),IconID=tonumber(XML.GetAttribute(sXMLPath, "iconid")),Enabled=CONVERT(XML.GetAttribute(sXMLPath, "enabled"),"boolean"),Checked=CONVERT(XML.GetAttribute(sXMLPath, "checked"),"boolean"),SubMenu={}};
[2] = XMLAttToString(XML.GetAttribute(sXMLPath, "code"));
};
return tRet
end
--===============================================================>>>>>>>

	for a = 1, XML.Count("menu", "*") do
	local tAtts = GetAtts("menu/*:"..a);
	tMenu[a] = tAtts[1];
	MENU_CODE[tAtts[1].ID] = tAtts[2];
			
		for b = 1, XML.Count("menu/:"..a, "*") do
		local tAtts = GetAtts("menu/*:"..a.."/:"..b);
		tMenu[a].SubMenu[b] = tAtts[1];
		MENU_CODE[tAtts[1].ID] = tAtts[2];
				
			for c = 1, XML.Count("menu/:"..a.."/:"..b, "*") do
			local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c);
			tMenu[a].SubMenu[b].SubMenu[c] = tAtts[1];  
			MENU_CODE[tAtts[1].ID] = tAtts[2];
						
				for d = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c, "*") do
				local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d);
				tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d] =tAtts[1];
				MENU_CODE[tAtts[1].ID] = tAtts[2];
					
					for e = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d, "*") do
					local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e);
					tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e] = tAtts[1];
					MENU_CODE[tAtts[1].ID] = tAtts[2];
					
						for f = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e, "*") do
						local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f);
						tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f] = tAtts[1];
						MENU_CODE[tAtts[1].ID] = tAtts[2];
							
							for g = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f, "*") do
							local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g);
							tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g] = tAtts[1];
							MENU_CODE[tAtts[1].ID] = tAtts[2];
														
								for h = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g, "*") do
								local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h);
								tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g].SubMenu[h] = tAtts[1];  
								MENU_CODE[tAtts[1].ID] = tAtts[2];
									
									for i = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h, "*") do
									local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i);
									tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g].SubMenu[h].SubMenu[i] = tAtts[1];
									MENU_CODE[tAtts[1].ID] = tAtts[2];
																		
										for j = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i, "*") do
										local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i.."/:"..j);
										tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g].SubMenu[h].SubMenu[i].SubMenu[j] = tAtts[1];
										MENU_CODE[tAtts[1].ID] = tAtts[2];
											
											for k = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i.."/:"..j, "*") do
											local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i.."/:"..j.."/:"..k);
											tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g].SubMenu[h].SubMenu[i].SubMenu[j].SubMenu[k] = tAtts[1];
											MENU_CODE[tAtts[1].ID] = tAtts[2];
											
												for l = 1, XML.Count("menu/:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i.."/:"..j.."/:"..k, "*") do
												local tAtts = GetAtts("menu/*:"..a.."/:"..b.."/:"..c.."/:"..d.."/:"..e.."/:"..f.."/:"..g.."/:"..h.."/:"..i.."/:"..j.."/:"..k.."/:"..l);
												tMenu[a].SubMenu[b].SubMenu[c].SubMenu[d].SubMenu[e].SubMenu[f].SubMenu[g].SubMenu[h].SubMenu[i].SubMenu[j].SubMenu[k].SubMenu[l] = tAtts[1];
												MENU_CODE[tAtts[1].ID] = tAtts[2];
												end			
											
											end			
													
										end			
				
									end			
													
								end			
								
								
							end			
							
						end			
										
					end			
					
				end			
				
			end
			
		end
		
	end

return tMenu
else
return nil
end
end
-- END | HIDDEN FUNCTIONS
--=============================================================<<<<<<<<<<<<
--|
--|
--|
--|
--|
--=============================================================<<<<<<<<<<<<
-- BEGIN | MAIN FUNCTIONS



--========================
-- Menu.Create
--========================
function Menu.Create(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if not MENU_MENUS[sMenu] then
MENU_MENUS[sMenu] = "<menu></menu>";
return 0
else
return 1
end
end



--========================
-- Menu.DoesExist
--========================
function Menu.DoesExist(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if MENU_MENUS[sMenu] then
return true
else
return false
end
end



--========================
-- Menu.Enable
--========================
function Menu.Enable(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local bActive = IRLUA_PLUGIN_CheckTypes(arg,1,{"boolean"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Application.SetMenuBarActive(bActive);
end



--========================
-- Menu.GetActive
--========================
function Menu.GetActive()
return MENU_ACTIVE
end



--========================
-- Menu.GetChecked
--========================
function Menu.GetChecked(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local sChecked = XML.GetAttribute(sPath, "checked");

RestoreXML();

	if sChecked ~= "" then
		
		if sChecked == "true" then
		return true
		else
		return false
		end
		
	else
	return false
	end

else
return -3
end

end



--========================
-- Menu.GetEnabled
--========================
function Menu.GetEnabled(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local sEnabled = XML.GetAttribute(sPath, "enabled");
	
RestoreXML();

	if sEnabled ~= "" then
		
		if sEnabled == "true" then
		return true
		else
		return false
		end
		
	else
	return false
	end

else
return -3
end

end



--========================
-- Menu.GetNames
--========================
function Menu.GetNames()
local tRet = {};
if MENU_MENUS then
	
	for sIndex, sXML in pairs(MENU_MENUS) do
	tRet[#tRet + 1] = sIndex;
	end
	
end

return tRet
end



--========================
-- Menu.GetItemProperties
--========================
function Menu.GetItemProperties(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local tRet = {
				ID=tonumber(XML.GetAttribute(sPath, "id")),
				Text=XML.GetAttribute(sXMLPath, "text"),
				IconID=tonumber(XML.GetAttribute(sPath, "iconid")),
				Enabled=CONVERT(XML.GetAttribute(sPath, "enabled"),"boolean"),
				Checked=CONVERT(XML.GetAttribute(sPath, "checked"),"boolean"),
			 };

RestoreXML();
return tRet
else
return -3
end

end



--========================
-- Menu.GetTable
--========================
function Menu.GetTable(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.DoesExist(sMenu) then
StoreXML(sMenu);
local tMenu = ParseXMLToMenu(sMenu);
RestoreXML();
return tMenu
else
return -1
end
end



--========================
-- Menu.GetXML
--========================
function Menu.GetXML(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.DoesExist(sMenu) then
return MENU_MENUS[sMenu]
else
return -1
end
end



--========================
-- Menu.LoadFromFile
--========================
function Menu.LoadFromFile(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sXMLFile = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if not File.DoesExist(sXMLFile) then
return -4
else
MENU_MENUS[sMenu] = TextFile.ReadToString(sXMLFile);
return 0
end
end



--========================
-- Menu.OnMenu
--========================
function Menu.OnMenu(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local e_ID = IRLUA_PLUGIN_CheckTypes(arg,1,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.GetActive() ~= "" then
	
	if MENU_CODE[e_ID] then
	loadstring(MENU_CODE[e_ID])();	
	end

end
end



--========================
-- Menu.RemoveItem
--========================
function Menu.RemoveItem(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();

if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local sID = XML.GetAttribute(sPath, "id");

	if sID ~= "" then
	local nID = tonumber(sID);
	
		if MENU_CODE[nID] then
		MENU_CODE[nID] = nil;
		end
		
	end

XML.RemoveElement(sPath);
MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
RestoreXML();
return 0
else
return -3
end

end



--========================
-- Menu.Rename
--========================
function Menu.Rename(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sNewName = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.DoesExist(sMenu) then

	if not Menu.DoesExist(sNewName) then
	MENU_MENUS[sNewName] = MENU_MENUS[sMenu];
	MENU_MENUS[sMenu] = nil;
		
		if Menu.GetActive() == sMenu then
		Menu.SetActive(sNewName);
		end
		
	return 0	
	else
	return 1
	end
	
else
return -1
end

end



--========================
-- Menu.RenameItem
--========================
function Menu.RenameItem(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sNewName = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,3,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();

if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
XML.SetAttribute(sPath, "text", sNewName);

MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end

RestoreXML();
return 0
else
return -3
end

end



--========================
-- Menu.SaveToFile
--========================
function Menu.SaveToFile(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sXMLFile = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if Menu.DoesExist(sMenu) then
TextFile.WriteFromString(sXMLFile, MENU_MENUS[sMenu], false);
	
	if Application.GetLastError() == 0 then
	return 0
	else
	return -4
	end
	
else
return -1
end
end



--========================
-- Menu.SetActive
--========================
function Menu.SetActive(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if not MENU_MENUS[sMenu] then
MENU_MENUS[sMenu] = "<menu></menu>";
end

MENU_ACTIVE = sMenu;
end



--========================
-- Menu.SetChecked
--========================
function Menu.SetChecked(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local bChecked = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,3,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
XML.SetAttribute(sPath, "checked", CONVERT(bChecked, "string"));

MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
RestoreXML();
return 0
else
return -3
end

end



--========================
-- Menu.SetEnabled
--========================
function Menu.SetEnabled(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local bEnabled = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,3,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
XML.SetAttribute(sPath, "enabled", CONVERT(bEnabled, "string"));

MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
RestoreXML();
else
return -3
end

end



--========================
-- Menu.SetDelmiter
--========================
function Menu.SetDelmiter(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sDelimiter = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if sDelimiter ~= "" then
local tChars = {"\r\n","\\","\'","\"","<",">","="};
local bContinue = true;

	for nIndex, sChar in pairs(tChars) do
	
		if sDelimiter == sChar then
		bContinue = false;
		break;
		end
		
	end

	if bContinue then
	MENU_DELIMITER = sDelimiter;
	end
	
end
return MENU_DELIMITER
end

--========================
-- Menu.SetItem
--========================
function Menu.SetItem(...)
IRLUA_PLUGIN_CheckNumArgs(arg,5);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local nIconID = IRLUA_PLUGIN_CheckTypes(arg,2,{"number"});
local bEnabled = IRLUA_PLUGIN_CheckTypes(arg,3,{"boolean"});
local bChecked = IRLUA_PLUGIN_CheckTypes(arg,4,{"boolean"});
local sCode = IRLUA_PLUGIN_CheckTypes(arg,5,{"string"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,6,{"boolean","nil"});
sCode = StringToXMLAtt(sCode);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();

if sActiveMenu ~= "" then
local tMenuItems = DSTT(sMenuString, MENU_DELIMITER);

	if tMenuItems then
	StoreXML(sActiveMenu);
	local sPath = "menu";
	local nTotalItems = Table.Count(tMenuItems);
		
		for nIndex, sItem in pairs(tMenuItems) do
		local sText = sItem;
		local nID = Math.Random(1, 10000);
			
			if sItem == "---" then
			sItem = "SEPARATOR-"..""..nID.."";
			sText = "---";
			end
		
		sPath = sPath.."/"..sItem;	
		sPath = GetFormattedPath(sPath);
					
			if XML.GetAttribute(sPath, "iconid") == "" then
			XML.SetValue(sPath, "", false);
			XML.SetAttribute(sPath, "id", ""..nID.."");	
			XML.SetAttribute(sPath, "text", sText);	
			XML.SetAttribute(sPath, "iconid", "0");
			XML.SetAttribute(sPath, "enabled", "true");
			XML.SetAttribute(sPath, "checked", "false");
			XML.SetAttribute(sPath, "code", "");
			end
			
			if nIndex == nTotalItems then
			XML.SetAttribute(sPath, "text", sText);	
			XML.SetAttribute(sPath, "iconid", CONVERT(nIconID,"string"));
			XML.SetAttribute(sPath, "enabled", CONVERT(bEnabled,"string"));
			XML.SetAttribute(sPath, "checked", CONVERT(bChecked,"string"));
			XML.SetAttribute(sPath, "code", sCode);
			end
		
		end
	
	MENU_MENUS[sActiveMenu] = XML.GetXML();

	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
	RestoreXML();
	return 0
	else
	return -2
	end
				
else
return -3
end
end



--========================
-- Menu.SetXML
--========================
function Menu.SetXML(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sMenu = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sXML = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
MENU_MENUS[sMenu] = sXML;
end



--========================
-- Menu.ToggleChecked
--========================
function Menu.ToggleChecked(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local sStatus = XML.GetAttribute(sPath, "checked");
if sStatus == "true" then
XML.SetAttribute(sPath, "checked", "false");
elseif sStatus == "false" then
XML.SetAttribute(sPath, "checked", "true");
end

MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
RestoreXML();
return 0
else
return -3
end

end



--========================
-- Menu.ToggleEnabled
--========================
function Menu.ToggleEnabled(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuString = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local bAutoUpdate = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean","nil"});
sMenuString = GetFormattedPath(sMenuString);
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local sActiveMenu = Menu.GetActive();
if sActiveMenu ~= "" then
StoreXML(sActiveMenu);

local sPath = MenuStringToXMLPath(sMenuString);
local sStatus = XML.GetAttribute(sPath, "enabled");
if sStatus == "true" then
XML.SetAttribute(sPath, "enabled", "false");
elseif sStatus == "false" then
XML.SetAttribute(sPath, "enabled", "true");
end

MENU_MENUS[sActiveMenu] = XML.GetXML();
	
	if bAutoUpdate then
	Application.SetMenu(ParseXMLToMenu(sActiveMenu));
	end
	
RestoreXML();
return 0
else
return -3
end

end



--============================
-- Menu.UnderlineMainMenuItem
--============================
function Menu.UnderlineMainMenuItem(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sMenuItem = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


end



--========================
-- Menu.Update
--========================
function Menu.Update()
local sActiveMenu = Menu.GetActive();

if sActiveMenu ~= "" then
StoreXML(sActiveMenu);
Application.SetMenu(ParseXMLToMenu(sActiveMenu));
RestoreXML();
return 0

else
return -3
end

end
-- END | MAIN FUNCTIONS
--=============================================================<<<<<<<<<<<<