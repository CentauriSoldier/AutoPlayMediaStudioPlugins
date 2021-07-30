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
local ERROR_PLUGIN_NAME = "SDB";
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
SDB = {};
SDB_OPEN_DBS = {};
SDB_DBS_PATHS = {};
SDB_LAST_ERROR = "";
SDB_NULL_CHARACTER = "";

--==================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- BEGIN | Hidden Functions and Tables

SDB_ERROR = {};
--database error codes (0 - 20)
SDB_ERROR[0] = "An unknown error as occured";
SDB_ERROR[1] = "Database opened successfully.";
SDB_ERROR[2] = "Database could not be opened.";
SDB_ERROR[3] = "Database closed successfully.";
SDB_ERROR[4] = "Database could not be closed.";
SDB_ERROR[5] = "Database saved succesfuly.";
SDB_ERROR[6] = "Database could not be saved.";
SDB_ERROR[7] = "Database closed and saved succesfuly.";
SDB_ERROR[8] = "Database is already open.";
SDB_ERROR[9] = "Database is not open.";
SDB_ERROR[10] = "Database does not exist.";
SDB_ERROR[11] = "Invalid Database name.";
SDB_ERROR[12] = "Invalid Filepath.";
--table error codes (21 - 40)
SDB_ERROR[21] = "Table created successfully.";
SDB_ERROR[22] = "Table could not be created.";
SDB_ERROR[23] = "Table already exists.";
SDB_ERROR[24] = "Table does not exist.";
SDB_ERROR[25] = "Table deleted successfully.";
SDB_ERROR[26] = "Table could not be deleted.";
SDB_ERROR[27] = "";
--record error codes (41 - 60)
--SDB_ERROR[] = "";
SDB_ERROR[41] = "Record created successfully.";
SDB_ERROR[42] = "Record could not be created.";
SDB_ERROR[43] = "Record already exists.";
SDB_ERROR[44] = "Record does not exist.";
SDB_ERROR[45] = "Record deleted successfully.";
SDB_ERROR[46] = "Record could not be successfully.";




local function SetError(nErrorID)
SDB_LAST_ERROR = SDB_ERROR[nErrorID];
end

local function NameIsValid() --complete this, but have it return true for now to facilitate code testing
return true
end


local function PathIsValid() --complete this, but have it return true for now to facilitate code testing
return true
end

-- END | Hidden Functions and Tables
--==================================================<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local SDB_TABLE_START = "|ü\\";
local SDB_TABLE_END = "/û|";
local SDB_RECORD_START = "|û\\";
local SDB_RECORD_END = "/û|";




--============================
-- SBD.Close
--============================
function SDB.Close(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local bSave = IRLUA_PLUGIN_CheckTypes(arg,2,{"boolean"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

TextFile.WriteFromTable(SDB_DBS_PATHS[sDB].."k", SDB_OPEN_DBS[sDB], false);

	if bSave then
	local tTypeCode = {["string"]="$",["number"]="#",["nil"]="!"}
	local sDBText = "";
	
		for sTableIndex, tTable in pairs(SDB_OPEN_DBS[sDB]) do
		sDBText = sDBText..SDB_TABLE_START..sTableIndex.."\r\n";
			
			for sRecordIndex, tRecord in pairs(tTable) do
			sDBText = sDBText..SDB_RECORD_START..sRecordIndex.."\r\n";
			
				for nIndex, vValue in pairs(tRecord) do
				sDBText = sDBText..tTypeCode[type(vValue)]..vValue;
				end
			
			sDBText = sDBText..SDB_RECORD_END.."\r\n";
			end
		
		sDBText = sDBText..SDB_TABLE_END.."\r\n";
		end
		
	TextFile.WriteFromString(SDB_DBS_PATHS[sDB], sDBText, false);
		
		local nError = Application.GetLastError();
		if nError == 0 then
		SetError(6);
		else
		return nError(7)
		end
	
	else
	SetError(3);
	end

SDB_OPEN_DBS[sDB] = nil;
SDB_DBS_PATHS[sDB] = nil;
else
SetError(9);
end
end



--============================
-- SBD.CreateTable
--============================
function SDB.CreateTable(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

	if not SDB_OPEN_DBS[sDB][sTable] then
	SDB_OPEN_DBS[sDB][sTable] = {};
	SDB_OPEN_DBS[sDB][sTable].Records = {};
	SDB_OPEN_DBS[sDB][sTable].Columns = {};
	SetError(21);
	else
	SetError(23);
	end

else
SetError(9);
end
end



--============================
-- SBD.DeleteTable
--============================
function SDB.DeleteTable(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SBD.IsOpen(sDB) then

	if SDB_OPEN_DBS[sDB][sTable] then
	SDB_OPEN_DBS[sDB][sTable] = nil;
	SetError(25);
	else
	SetError(24);
	end

else
SetError(9);
end
end



--============================
-- SBD.GetDatabases
--============================
function SDB.GetDatabases()
if Table.Count(SDB_OPEN_DBS) > 0 then
local tRet = {};
local nIndex = 0;

	for sIndex, sTable in pairs(SDB_OPEN_DBS) do
	nIndex = nIndex + 1;
	tRet[nIndex] = sIndex;
	end

return tRet
else
return nil
end
end


--============================
-- SBD.GetLastError
--============================
function SDB.GetLastError()
return SDB_LAST_ERROR
end



--============================
-- SBD.GetTables
--============================
function SDB.GetTables(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

	if Table.Count(SDB_OPEN_DBS[sDB]) > 0 then
	local tRet = {};
	local nIndex = 0;

		for sTable, vRecord in pairs(SDB_OPEN_DBS[sDB]) do
		nIndex = nIndex + 1;
		tRet[nIndex] = sTable;
		end
	
	return tRet
	else
	return nil
	end
	
else
SetError(9);
end
end



--============================
-- SBD.IsOpen
--============================
function SDB.IsOpen(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB_OPEN_DBS[sDB] then
return true
else
return false
end
end



--============================
-- SBD.Open
--============================
function SDB.Open(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sFile = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if NameIsValid(sDB) then
	
	if PathIsValid() then
	
		if not SDB.IsOpen(sDB) then
		SDB_OPEN_DBS[sDB] = {};
		SDB_DBS_PATHS[sDB] = sFile;
		SetError(1);
		return sDB
		else
		SetError(8);
		return sDB
		end
	
	else
	SetError(12);
	return sFile
	end
		
else
SetError(11);
return sDB
end
end



--============================
-- SBD.TableDoesExist
--============================
function SDB.TableDoesExist(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

	if SDB_OPEN_DBS[sDB][sTable] then
	return true
	else
	return false
	end

else
SetError(9);
return false
end
end



--============================
-- SBD.CreateRecord
--============================
function SDB.CreateRecord(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
local sRecord = IRLUA_PLUGIN_CheckTypes(arg,3,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

	if not SDB.TableDoesExist(sTable) then
	SDB.CreateTable(sTable);
	end
	
	if not SDB_OPEN_DBS[sDB][sTable][sRecord] then
	SDB_OPEN_DBS[sDB][sTable].Records[Table.Count(SDB_OPEN_DBS[sDB][sTable].Records) + 1] = sRecord;
	SDB_OPEN_DBS[sDB][sTable][sRecord] = {};
		
		for x = 1, SDB.CountColumns() do
		SDB_OPEN_DBS[sDB][sTable][sRecord][Table.Count(SDB_OPEN_DBS[sDB][sTable][sRecord]) + 1] = SDB_NULL_CHARACTER;
		end
		
	else
	SetError(43);
	end

	if bGetColumns then
		
	end

else
SetError(9);
end
end



function SDB_GetRecordID ()



end


function SDB.GetColumns(sDB, sTable)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then

	if SDB.TableDoesExist(sTable) then
	else
	SetError(24);
	return nil
	end	

else
SetError(9);
return nil
end
end





function SDB.GetRecords(sDB, Table)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then
	
	if SDB.TableDoesExist(sTable) then
	
	
	else
	SetError(24);
	return nil
	end

else
SetError(9);
return nil
end
end




function SDB.CountRecords(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then
	
	if SDB.TableDoesExist(sTable) then
		
		if SDB_OPEN_DBS[sDB][sTable].Records then
		return Table.Count(SDB_OPEN_DBS[sDB][sTable].Records);
		else
		return 0
		end
	
	else
	SetError(24);
	return 0
	end

else
SetError(9);
return 0
end
end





function SDB.CountColumns(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local sDB = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"})
local sTable = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"})
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if SDB.IsOpen(sDB) then
	
	if SDB.TableDoesExist(sTable) then
		
		if SDB_OPEN_DBS[sDB][sTable].Columns then
		return Table.Count(SDB_OPEN_DBS[sDB][sTable].Columns);
		else
		return 0
		end
	
	else
	SetError(24);
	return 0
	end

else
SetError(9);
return 0
end
end



--[[
++ Heirarchy ++
Database
Table
Cell (Row, Column)
]]



--[[
Consider using encryption
test whether or not using "local tTemp = SDB_OPEN_DBS[sTable)" is faster than using the global table
consider using separate tables for all databases
maybe even consider subtable (although this might defeat the purpose of making this simple)
Maybe use those cool little symbols for delimiters (MUST create table delimiters first then other delimiters)
also, consider adding the ability to have Multi-tier databases, that is, databases within databases. We would need to use a textfile.writefromtable type method but write it to memory instead (as a string). Call the main file a "Datablock".

Note on the "Edit" functions: if the item does not exist then it will be created.

planned functions

HIDDEN-----
table does exist
column does exist
record does exist
-----HIDDEN

Database Functions

SDB.GetAutoVacuum (really look, in detail, at these functions and make them simple and change the word "vacuum")
SDB.SetAutoVacuum
--used for manually saving a db even though the close function will save them too >>>
SDB.Save(tDB)
SDB.SaveAll(tDB)
--used for manually saving a db even though the close function will save them too <<<
SDB.Close(tDB) SAVE HERE BASED ON USER INPUT OF TRUE or false
SDB.CloseAll()


Table functions
SDB.ClearTable(tDB, sTable)

SDB.CountTables(tDB)
SDB.DeleteTable(tDB, sTable)
SDB.GetTables(tDB)
SDB.RenameTable(tDB, sOldTable, sNewTable)



Column functions


Record functions



]]



--_SDB_DATABASES
--_SDB_TABLE_BOUND_START
--_SDB_TABLE_BOUND_END
--_SDB_

--each entry will be proceeded by a single character indicating its type
--[[
$ = string
# = number
* = boolean
! = BLOB




--Table Functions
AddTable



SDB.Create()
SDB.Save()
SDB.Load()
SDB.()
SDB.()
SDB.()
SDB.()
SDB.()
SDB.()


SDB.GetTables()
SDB.Get]]