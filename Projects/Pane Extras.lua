


--==================
-- PageDoesExist
--==================
local function PageDoesExist(sPage)
if type(sPage) == "string" then

	if tPages then
	
		for nIndex, sRealPage in pairs(tPages) do
		
			if sPage == sRealPage then
			return true			
			end
			
		end
		
	end
	
end

return false
end



--[[==================
-- Page.Jump
--==================
local Page_Jump = Page.Jump;
function Page.Jump(sPage)
if PageDoesExist(sPage) then

	for sPane, tPane in pairs(tPanes) do
			
		for sObject, tObject in pairs(tPanes[sPane].Objects) do
		local fMethod = tTypes[tPanes[sPane].Objects[sObject].Type];
			
			if type(fMethod.GetProperties) == "function" and type(fMethod.SetProperties) == "function" and type(fMethod.SetPos) == "function" and type(fMethod.SetVisible) == "function" and tPanes[sPane].Persist == true then
			Action().DeleteObject(sObject);			
			else
			Rane.RemoveObject(sPane, sObject);
			end
					
		end
			
	end	

Page_Jump(sPage);
end
end
]]


--[[
--===================
-- Pane.AddAMSObject
--===================
function Pane.AddAMSObject(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sObject = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local tPos = IRLUA_PLUGIN_CheckTypes(arg,3,{"table","nil"});
local tSize = IRLUA_PLUGIN_CheckTypes(arg,4,{"table","nil"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then
local nObjectType = Action().GetObjectType(sObject);
local fMethod = tTypes[nObjectType];
		
	if fMethod then
	local hObject = fMethod.GetProperties(sObject).WindowHandle;
	
		if hObject then
			
			if not Pane.AMSObjectIsInPane(sPane, sObject) then
			tPanes[sPane].AMSObjects[sObject] = {
			IsInPane = true,
			OuterX = -(Pane.GetAMSObjectCount(sPane) * 1500) - 4000,
			OuterY = -(Pane.GetAMSObjectCount(sPane) * 1500) - 4000,
			X = 0,
			Y = 0,
			Width = 0,
			Height = 0,			
			OrigX = 0,
			OrigY = 0,
			OrigWidth = 0,
			OrigHeight = 0,			
			Props = {},
			Type = nObjectType,
			};
						
				if type(fMethod.GetProperties) == "function" then
				local tProps = fMethod.GetProperties(sObject);			
				tPanes[sPane].AMSObjects[sObject].X = tProps.X;
				tPanes[sPane].AMSObjects[sObject].Y = tProps.Y;
				tPanes[sPane].AMSObjects[sObject].Width= tProps.Width;
				tPanes[sPane].AMSObjects[sObject].Height = tProps.Height;
				tPanes[sPane].AMSObjects[sObject].OrigX = tProps.X;
				tPanes[sPane].AMSObjects[sObject].OrigY = tProps.Y;
				tPanes[sPane].AMSObjects[sObject].OrigWidth= tProps.Width;
				tPanes[sPane].AMSObjects[sObject].OrigHeight = tProps.Height;
				end
				
				
				local bVisible = false;
				local bShowMe = false;
				
				if type(fMethod.IsVisible) == "function" and type(fMethod.SetVisible) == "function" then
				bVisible = fMethod.IsVisible(sObject);
				end
				
				if bVisible then
				fMethod.SetVisible(sObject, false);
				bShowMe = true;
				end
													
				if type(fMethod.SetSize) == "function" then
					
					if type(tSize) == "table" then
					
						if type(tSize.Width) == "number" and type(tSize.Height) == "number" then
						fMethod.SetSize(sObject, tSize.Width, tSize.Height);
						tPanes[sPane].AMSObjects[sObject].Width = tSize.Width;
						tPanes[sPane].AMSObjects[sObject].Height = tSize.Height;
						end
					
					end
					
				end					
							
				if type(fMethod.SetPos) == "function" then
					
					if type(tPos) == "table" then
					
						if type(tPos.X) == "number" and type(tPos.Y) == "number" then
						tPanes[sPane].AMSObjects[sObject].X = tPos.X;
						tPanes[sPane].AMSObjects[sObject].Y = tPos.Y;
						fMethod.SetPos(sObject, tPanes[sPane].AMSObjects[sObject].OuterX, tPanes[sPane].AMSObjects[sObject].OuterY);
						Window.SetPos(hObject, tPos.X, tPos.Y);
						end
					
					end
					
				end
								
			Window_SetParent(hObject, tPanes[sPane].Handle);
			
				if bShowMe then
				fMethod.SetVisible(sObject, true);
				end			
			
			end
		
		else
		
			if tPanes[sPane].AMSObjects[sObject] then
			tPanes[sPane].AMSObjects[sObject] = nil;
			end
		
		end
		
	end
	
end
end
]]
--[[
--========================
-- Pane.AMSObjectIsInPane
--========================
function Pane.AMSObjectIsInPane(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sObject = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then
local nType = Action().GetObjectType(sObject);

	if nType ~= -1 then
	local fMethod = tTypes[nType];
	
		if type(fMethod.GetProperties) == "function" then
		local tProps = fMethod.GetProperties(sObject);
			
			if tProps then
			
				if type(tProps.WindowHandle) == "number" then
				local nParent = Window_GetParent(tProps.WindowHandle);
				
					if type(nParent) == "number" then
					
						if nParent == tPanes[sPane].Handle then
						return true
						end
						
					end
					
				end
			
			end
		
		end
		
	end
	
end

return false
end
]]


--[[
--========================
-- Pane.GetAMSObjectCount
--========================
function Pane.GetAMSObjectCount(...)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then
local nObjects = 0;

	if tPanes[sPane].AMSObjects then
	
		for sObject, tObjects in pairs(tPanes[sPane].AMSObjects) do
			
			if Pane.AMSObjectIsInPane(sPane, sObject) then
			nObjects = nObjects + 1;
			end
			
		end

	end

return nObjects
else
return -1

end
end
]]


--[[==================
-- Pane.OnShow
--==================
function Pane.OnShow()
for sPane, tPane in pairs(tPanes) do
		
	if Pane.IsValid(sPane) and tPanes[sPane].Persist == true then
			
		for sObject, tObject in pairs(tPanes[sPane].Objects) do
			
			if tPanes[sPane].Objects[sObject].Props then
			local fMethod = tTypes[tPanes[sPane].Objects[sObject].Type];
			local tOldObject = tPanes[sPane].Objects[sObject];
			local bVisible = tPanes[sPane].Objects[sObject].Props.Visible;
			local bShowMe = false;	
			
				if bVisible then
				tPanes[sPane].Objects[sObject].Props.Visible = false;
				bShowMe = true;
				end
			
			Action().CreateObject(tObject.Type, sObject, tPanes[sPane].Objects[sObject].Props);
			
			local hObject = fMethod.GetProperties(sObject).WindowHandle;
			tPanes[sPane].Objects[sObject].Props.WindowHandle = hObject;
				
			fMethod.SetPos(sObject,  tPanes[sPane].Objects[sObject].OuterX,  tPanes[sPane].Objects[sObject].OuterY);
			Window_SetParent(hObject, tPanes[sPane].Handle);
			Pane.SetObjectPos(sPane, sObject, tPanes[sPane].Objects[sObject].X, tPanes[sPane].Objects[sObject].Y);
			
				if bShowMe then
				tPanes[sPane].Objects[sObject].Props.Visible = true;
				fMethod.SetVisible(sObject, true);
				end
			
			tPanes[sPane].Objects[sObject] = tOldObject;
			end		
				
		end
		
	end	
							
end	
end
]]


--THIS NEEDS FIXED!!!!!!!!!!!!! needs to have the IsInPane attribute added and just change parents, not be deleted and recreated

--======================
-- Pane.RemoveAMSObject
--======================
function Pane.RemoveAMSObject(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sObject = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local tPos = IRLUA_PLUGIN_CheckTypes(arg,3,{"table","nil"});
local tSize = IRLUA_PLUGIN_CheckTypes(arg,4,{"table","nil"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

	if tPanes[sPane].AMSObjects[sObject] then
		
		if Pane.AMSObjectIsInPane(sPane, sObject) then
		local fMethod = tTypes[tPanes[sPane].AMSObjects[sObject].Type];
		
			if type(fMethod.GetProperties) then
				
				local tProps = fMethod.GetProperties(sObject);
				tProps.X = tPanes[sPane].AMSObjects[sObject].OrigX;
				tProps.Y = tPanes[sPane].AMSObjects[sObject].OrigY;
				tProps.Width = tPanes[sPane].AMSObjects[sObject].OrigWidth;
				tProps.Height = tPanes[sPane].AMSObjects[sObject].OrigHeight;
				
				local bShowMe = false;
				if tProps.Visible then
				
					if type(fMethod.SetVisible) == "function" then
					tProps.Visible = false;
					bShowMe = true;
					end
					
				end
				
				if type(tPos) == "table" then
				
					if type(tPos.X) == "number" and type(tPos.Y) == "number" then
					tProps.X = tPos.X;
					tProps.Y = tPos.Y;
					end
					
				end
				
				if type(tSize) == "table" then
				
					if type(tSize.Width) == "number" and type(tSize.Height) == "number" then
					tProps.Width = tSize.Width;
					tProps.Height = tSize.Height;
					end
					
				end
					
				Action().DeleteObject(sObject);
				Action().CreateObject(tPanes[sPane].AMSObjects[sObject].Type, sObject, tProps)
				
				if bShowMe then
				fMethod.SetVisible(sObject, true);
				end
				
			end
					
		end
		
	end

end
end



--======================
-- Pane.SetAMSObjectPos
--======================
function Pane.SetAMSObjectPos(...)
IRLUA_PLUGIN_CheckNumArgs(arg,4);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sObject = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local nX = IRLUA_PLUGIN_CheckTypes(arg,3,{"number"});
local nY = IRLUA_PLUGIN_CheckTypes(arg,4,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

	if Pane.AMSObjectIsInPane(sPane, sObject) then
	local nType = tPanes[sPane].AMSObjects[sObject].Type;
					
		if nType ~= -1 then
		local fMethod = tTypes[nType];
	
			if type(fMethod.SetPos) == "function" then
			
				if type(fMethod.GetProperties) == "function" then
				local tProps = fMethod.GetProperties(sObject);
				
					if tProps then
						
						if type(tProps.WindowHandle) == "number" then
						Window_MoveWindow(tProps.WindowHandle, nX, nY, tPanes[sPane].AMSObjects[sObject].Width, tPanes[sPane].AMSObjects[sObject].Height, true);
						tPanes[sPane].AMSObjects[sObject].X = nX;
						tPanes[sPane].AMSObjects[sObject].Y = nY;
						end
						
					end
					
				end
								
			end
			
		end
	
	end
	
end
end



--=======================
-- Pane.SetAMSObjectSize
--=======================
function Pane.SetAMSObjectSize(...)
IRLUA_PLUGIN_CheckNumArgs(arg,4);
local sPane = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sObject = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
local nWidth = IRLUA_PLUGIN_CheckTypes(arg,3,{"number"});
local nHeight = IRLUA_PLUGIN_CheckTypes(arg,4,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

	if Pane.AMSObjectIsInPane(sPane, sObject) then
	local nType = tPanes[sPane].AMSObjects[sObject].Type;
					
		if nType ~= -1 then
		local fMethod = tTypes[nType];
	
			if type(fMethod.SetPos) == "function" then
			
				if type(fMethod.GetProperties) == "function" then
				local tProps = fMethod.GetProperties(sObject);
				
					if tProps then
						
						if type(tProps.WindowHandle) == "number" then
						Window_MoveWindow(tProps.WindowHandle, tPanes[sPane].AMSObjects[sObject].X, tPanes[sPane].AMSObjects[sObject].Y, nWidth, nHeight, true);
						tPanes[sPane].AMSObjects[sObject].Width = nWidth;
						tPanes[sPane].AMSObjects[sObject].Height = nHeight;
						end
						
					end
					
				end
								
			end
			
		end
	
	end
	
end
end














--[[====================
-- XMLSave_GetObjects
--====================
local function XMLSave_GetObjects(sPane)
local sRet = "";

	for sObject, tObject in pairs(tPanes[sPane].Objects) do
	local sProps = "";
	local tStrings = {
	"OuterX="..tObject.OuterX,
	"OuterY="..tObject.OuterY,
	"X="..tObject.X,
	"Y="..tObject.Y,
	"Width="..tObject.Width,
	"Height="..tObject.Height,
	"OrigX="..tObject.OrigX,
	"OrigY="..tObject.OrigY,
	"OrigWidth="..tObject.OrigWidth,
	"OrigHeight="..tObject.OrigHeight,
	};
		for nIndex, sString in pairs(tStrings) do
		sProps = sProps..sString.."!";
		end
	
	sRet = sRet..sObject.."("..String.TrimRight(sProps, "!")..")".."|";
	end

return String.TrimRight(sRet, "|");
end]]