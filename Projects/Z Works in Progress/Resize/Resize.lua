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
local ERROR_PLUGIN_NAME = "Resize";
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
Resize = {};
bFirstRunSIZE = true;
tRESIZETurnBackOn = {};
RESIZE_EXCLUDE_PREFIX = "x_";

local tTypes = {
[OBJECT_BUTTON] = Button,
[OBJECT_CHECKBOX] = CheckBox,
[OBJECT_COMBOBOX] = ComboBox,
[OBJECT_FLASH] = Flash,
[OBJECT_GRID] = Grid,
[OBJECT_HOTSPOT] = Hotspot,
[OBJECT_IMAGE] = Image,
[OBJECT_INPUT] = Input,
[OBJECT_LABEL] = Label,
[OBJECT_LISTBOX] = ListBox,
[OBJECT_PARAGRAPH] = Paragraph,
[OBJECT_PLUGIN] = Plugin,
[OBJECT_PROGRESS] = Progress,
[OBJECT_RADIOBUTTON] = RadioButton,
[OBJECT_RICHTEXT] = RichText,
[OBJECT_SLIDESHOW] = SlideShow,
[OBJECT_TREE] = Tree,
[OBJECT_VIDEO] = Video,
[OBJECT_WEB] = Web,
[OBJECT_XBUTTON] = xButton,
};




-- This allows the user to exclude objects from resizing based on name prefix
function Resize.Exclude(sObject)

if String.Lower(String.Left(sObject, String.Length(RESIZE_EXCLUDE_PREFIX))) ~= String.Lower(RESIZE_EXCLUDE_PREFIX) then
return false
else
return true
end

end



---------------------------------------------------------------------------
--Function Resize_OnSize;
--This function is in place to reduce the amount of code that must go on
--each pages "On Size" event
---------------------------------------------------------------------------
function Resize.OnSize(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2)
local PageWidth = IRLUA_PLUGIN_CheckNumber(arg,1)
local PageHeight = IRLUA_PLUGIN_CheckNumber(arg,2)
	if bFirstRunSIZE then
		Resize.setOriginalPageSize(PageWidth,PageHeight);
		bFirstRunSIZE = false;
	end
	Resize.SetSize(PageWidth,PageHeight);
end


---------------------------------------------------------------------------
--Function Resize_OnPreLoad();
--This function is in place to reduce the amount of code that must go on
--each pages "On Preload" event
---------------------------------------------------------------------------
function Resize.OnPreLoad()
	Resize.getOriginalPositions();
	Size = Page.GetSize();
	if not bFirstRunSIZE then
		Resize.SetSize(Size.Width,Size.Height);
	end
end


-- This is a global variable that is used to determine the first time that 
-- This page has been Accessed


---------------------------------------------------------------------------
--Function setOriginalPageSize
--This function is used to set a global table with the original page
--size of your project
---------------------------------------------------------------------------
function Resize.setOriginalPageSize(WidthO,HeightO)
	-- Store these values in a global table. This action is only
	-- performed once.
	tblOriginalSize = {Width=WidthO,Height=HeightO};
end



---------------------------------------------------------------------------
--Function RevertSize
--This function puts all objects back to their original position and size
--This makes the page look proper if the project is resized on a different
--page.
---------------------------------------------------------------------------
function Resize.OnClose()
Application.SetRedraw(false);
	
	-- The loop will go through all of the entries in the global table tblOriginalPos
	-- and set all of the objects back to their original state.
	for i = 1, Table.Count(tblOriginalPos) do
		-- Get the table that is stored in the global table on every itteration of
		-- the loop
		tblPos = tblOriginalPos[i];
		
		-- The next if -> elseif block determines which type of object
		-- is currently in the table tblPos
		if tblPos.ObType == OBJECT_BUTTON then
			-- If it is a Button then set it back to its original size
			Button.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			-- If it is a Button then set it back to its original Position
			Button.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);			
		elseif tblPos.ObType == OBJECT_LABEL then
			if Label.IsVisible(tblPos.ObName) then
			Label.SetVisible(tblPos.ObName, false)
			tRESIZETurnBackOn[Table.Count(tRESIZETurnBackOn) + 1] = tblPos.ObName;
			end
			Label.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Label.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);			
		elseif tblPos.ObType == OBJECT_PARAGRAPH then
			Paragraph.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Paragraph.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_IMAGE then
			Image.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Image.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_FLASH then
			Flash.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Flash.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_VIDEO then
			Video.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Video.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_WEB then
			Web.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Web.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_INPUT then
			Input.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Input.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_HOTSPOT then
			Hotspot.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Hotspot.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_LISTBOX then
			ListBox.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			ListBox.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_COMBOBOX then
			ComboBox.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			ComboBox.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_PROGRESS then
			Progress.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Progress.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_TREE then
			Tree.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Tree.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_RADIOBUTTON then			
			RadioButton.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			RadioButton.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_RICHTEXT then
			RichText.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			RichText.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_CHECKBOX then
			CheckBox.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			CheckBox.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_SLIDESHOW then
			SlideShow.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			SlideShow.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_GRID then
			Grid.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Grid.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		elseif tblPos.ObType == OBJECT_PLUGIN then	
			Plugin.SetSize(tblPos.ObName,tblPos.W,tblPos.H);
			Plugin.SetPos(tblPos.ObName, tblPos.X, tblPos.Y);
		end		
	end
end


---------------------------------------------------------------------------
--Function getOriginalPositions
--This function enumerates all objects on the current page. It then stores
--information about the objects in a global table to be used for a 
--reference point to perform the position and size adjustments
--The following information is stored about each object:
-- Object Name
-- Object Type
-- Width
-- Height
-- Position X
-- Position Y
---------------------------------------------------------------------------
function Resize.getOriginalPositions ()
	-- The master table that contains information about each object on the page
	tblOriginalPos = {};
	-- The table that will be stored in the above master table. Each objects 
	-- information will be stored in the below table
	Pos = {};
	-- Get all of the objects on a page
	local tObjects = Page.EnumerateObjects();
	-- Loop through each object on the page
	
	if tObjects then
	
	for i = 1, Table.Count(Objects) do
	
		if not Resize.Exclude(Objects[i]) then
		z = Table.Count(tblOriginalPos) + 1;
		-- Find out what TYPE of object it is.
		Type = Page.GetObjectType(Objects[i]);
		-- If it is a Button then
			if Type == OBJECT_BUTTON then			
				-- Get the size
				Size = Button.GetSize(Objects[i]);
				-- Get the Position
				Position = Button.GetPos(Objects[i]);
				-- Set the table up to store this information
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_BUTTON};
				-- Store the 'Pos' table in the master table tblOriginalPos
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_LABEL then
				Size = Label.GetSize(Objects[i]);
				Position = Label.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_LABEL};
				tblOriginalPos[z] = Pos; 
			elseif Type == OBJECT_PARAGRAPH then
				Size = Paragraph.GetSize(Objects[i]);
				Position = Paragraph.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_PARAGRAPH};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_IMAGE then
				Size = Image.GetSize(Objects[i]);
				Position = Image.GetPos(Objects[i]);	
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_IMAGE};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_FLASH then
				Size = Flash.GetSize(Objects[i]);
				Position = Flash.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_FLASH};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_VIDEO then
				Size = Video.GetSize(Objects[i]);
				Position = Video.GetPos(Objects[i]);	
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_VIDEO};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_WEB then
				Size = Web.GetSize(Objects[i]);
				Position = Web.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_WEB};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_INPUT then
				Size = Input.GetSize(Objects[i]);
				Position = Input.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_INPUT};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_HOTSPOT then
				Size = Hotspot.GetSize(Objects[i]);
				Position = Hotspot.GetPos(Objects[i]);	
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_HOTSPOT};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_LISTBOX then
				Size = ListBox.GetSize(Objects[i]);
				Position = ListBox.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_LISTBOX};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_COMBOBOX then
				Size = ComboBox.GetSize(Objects[i]);
				Position = ComboBox.GetPos(Objects[i]);	
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_COMBOBOX};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_PROGRESS then
				Size = Progress.GetSize(Objects[i]);
				Position = Progress.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_PROGRESS};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_TREE then
				Size = Tree.GetSize(Objects[i]);			
				Position = Tree.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_TREE};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_RADIOBUTTON then
				Size = RadioButton.GetSize(Objects[i]);			
				Position = RadioButton.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_RADIOBUTTON};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_RICHTEXT then
				Size = RichText.GetSize(Objects[i]);			
				Position = RichText.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_RICHTEXT};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_CHECKBOX then
				Size = CheckBox.GetSize(Objects[i]);			
				Position = CheckBox.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_CHECKBOX};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_SLIDESHOW then
				Size = SlideShow.GetSize(Objects[i]);			
				Position = SlideShow.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_SLIDESHOW};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_GRID then
				Size = Grid.GetSize(Objects[i]);			
				Position = Grid.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_GRID};
				tblOriginalPos[z] = Pos;
			elseif Type == OBJECT_PLUGIN then
				Size = Plugin.GetSize(Objects[i]);
				Position = Plugin.GetPos(Objects[i]);
				Pos = {W=Size.Width,H=Size.Height,X=Position.X,Y=Position.Y,ObName=Objects[i],ObType=OBJECT_PLUGIN};
				tblOriginalPos[z] = Pos;
			end
		end
	end
	
	
	
end





function Resize.SetExcludePrefix(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1)
local sNewPrefix = IRLUA_PLUGIN_CheckString(arg,1)
if sNewPrefix ~= "" and String.Replace(sNewPrefix, " ", "", false) ~= "" then
RESIZE_EXCLUDE_PREFIX = sNewPrefix
end
return RESIZE_EXCLUDE_PREFIX
end






---------------------------------------------
--Function SetSize
--This function is where the calculations for resizing and repositioning
--takes place. It accepts a page Width and Height as parameters. It then
--finds the ration between the original paage size and the current page size.
--Every object on the page is then repositioned and resized by the ration
--of the difference in size.
---------------------------------------------------------------------------
function Resize.SetSize(Width,Height)
--this table is used to handle the labels...they must be resized while page redraw is active or it will not work.
local tLabels = {};

	-- Get the original size of the page/project
	OriginalWidth = tblOriginalSize.Width;
	OriginalHeight = tblOriginalSize.Height;

	-- Calculate the difference between the original page size and the current
	RatioW = Width / OriginalWidth;
	RatioH = Height  / OriginalHeight;
	
	-- Turn off the redraw
	Application.SetRedraw(false);
	
	-- Now loop through the table that stores information about each object
	--and reposition and resize them according to the above ratio
	for i=1, Table.Count(tblOriginalPos) do
		-- Each item in tblOriginalPos is a table that holds specific informtion about 
		-- that object
		tblProps = tblOriginalPos[i];
		
		-- If the item is a Button
		if tblProps.ObType == OBJECT_BUTTON then			
			-- Set the position of the object
			Button.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			-- Set the size of the object
			Button.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_LABEL then
			--Label.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			--Application.SetRedraw(true);
			--Label.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
			--Application.SetRedraw(false);
			local nIndex = Table.Count(tLabels) + 1;
			tLabels[nIndex] = {};
			tLabels[nIndex].Name = tblProps.ObName;
			tLabels[nIndex].SizeW = tblProps.W * RatioW;
			tLabels[nIndex].SizeH = tblProps.H * RatioH;
			tLabels[nIndex].PosX = tblProps.X * RatioW;
			tLabels[nIndex].PosY = tblProps.Y * RatioH;
		elseif tblProps.ObType == OBJECT_PARAGRAPH then
			Paragraph.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Paragraph.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_IMAGE then
			Image.SetPos(tblProps.ObName, tblProps.X * RatioW, tblProps.Y * RatioH);
			Image.SetSize(tblProps.ObName, tblProps.W * RatioW, tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_FLASH then
			Flash.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Flash.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_VIDEO then
			Video.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Video.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_WEB then
			Web.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Web.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_INPUT then
			Input.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Input.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_HOTSPOT then
			Hotspot.SetPos(tblProps.ObName, tblProps.X * RatioW, tblProps.Y * RatioH);
			Hotspot.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_LISTBOX then
			ListBox.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			ListBox.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_COMBOBOX then
			ComboBox.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			ComboBox.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_PROGRESS then
			Progress.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Progress.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_TREE then
			Tree.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Tree.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_RADIOBUTTON then
			RadioButton.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			RadioButton.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_RICHTEXT then
			RichText.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			RichText.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_CHECKBOX then
			CheckBox.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			CheckBox.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_SLIDESHOW then
			SlideShow.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			SlideShow.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_GRID then
			Grid.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Grid.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		elseif tblProps.ObType == OBJECT_PLUGIN then
			Plugin.SetPos(tblProps.ObName,tblProps.X * RatioW, tblProps.Y * RatioH);
			Plugin.SetSize(tblProps.ObName,tblProps.W * RatioW,tblProps.H * RatioH);
		end
	end

-- Allow the page to redraw once all objects (except labels) have been adjusted
--labels must be resize while redraw is enable
Application.SetRedraw(true);

--resize and reposition the labels	
tLabelsToTurnOn = {};
for nIndex = 1, Table.Count(tLabels) do
local sObjectName = tLabels[nIndex].Name;

	--this is where we hide the lables that we are moving and resizing so we don't see them redraw
	if Label.IsVisible(sObjectName) then
	Label.SetVisible(sObjectName, false);
	tLabelsToTurnOn[Table.Count(tLabelsToTurnOn) + 1] = sObjectName;
	end

Label.SetSize(sObjectName, tLabels[nIndex].SizeW, tLabels[nIndex].SizeH);
Label.SetPos(sObjectName, tLabels[nIndex].PosX, tLabels[nIndex].PosY);
end

--all the labels that we set to invisible OnSize we turn back on here
for nIndex = 1, Table.Count(tLabelsToTurnOn) do
Label.SetVisible(tLabelsToTurnOn[nIndex], true);
end

--set the table to nil when were done so we don't repeat this code unnecessarily
tLabelsToTurnOn = {};

--all the labels that were set to invisible OnClose we turn back on here
for nIndex = 1, Table.Count(tRESIZETurnBackOn) do
Label.SetVisible(tRESIZETurnBackOn[nIndex], true);
end
------------------------------
end