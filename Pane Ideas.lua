--===================================================================================
--===================================================================================
--===================================================================================
--===================================================================================
function Pane.LoadFromFile(sPane, pFile)


end



function Pane.GetXML(sPane)
sPane = String.Lower(sPane);
local sXML = "";

if Pane.IsValid(sPane) then
local sUserXML = XML.GetXML();
XML.SetXML("<pane></pane>");

XML.SetAttribute("pane", "Name", sPane);
XML.SetAttribute("pane", "Attached", CONVERT(tPanes[sPane].Attached, "string"));
XML.SetAttribute("pane", "Border", tPanes[sPane].Border);
XML.SetAttribute("pane", "DetachToHere", CONVERT(tPanes[sPane].DetachToHere, "string"));
XML.SetAttribute("pane", "DockedLength", tPanes[sPane].DockedLength);
XML.SetAttribute("pane", "DockedType", tPanes[sPane].DockedType);
XML.SetAttribute("pane", "DockedMemory", "TABLE");
XML.SetAttribute("pane", "Handle", tPanes[sPane].Handle);
XML.SetAttribute("pane", "Objects", XMLSave_GetObjects(sPane));
XML.SetAttribute("pane", "Persist", CONVERT(tPanes[sPane].Persist, "string"));
XML.SetAttribute("pane", "Sizeable", CONVERT(tPanes[sPane].Sizeable, "string"));
XML.SetAttribute("pane", "Style", tPanes[sPane].Style);
XML.SetAttribute("pane", "Title", tPanes[sPane].Title);
XML.SetAttribute("pane", "TitleBar", CONVERT(tPanes[sPane].TitleBar, "string"));
XML.SetAttribute("pane", "Type", tPanes[sPane].Type);
XML.SetAttribute("pane", "Visible", CONVERT(tPanes[sPane].Visible, "string"));
XML.SetAttribute("pane", "X", tPanes[sPane].X);
XML.SetAttribute("pane", "Y", tPanes[sPane].Y);
XML.SetAttribute("pane", "ExtX", tPanes[sPane].ExtX);
XML.SetAttribute("pane", "ExtY", tPanes[sPane].ExtY);
XML.SetAttribute("pane", "Width", tPanes[sPane].Width);
XML.SetAttribute("pane", "Height", tPanes[sPane].Height);
XML.SetAttribute("pane", "ExtWidth", tPanes[sPane].ExtWidth);
XML.SetAttribute("pane", "ExtHeight", tPanes[sPane].ExtHeight);

sXML = XML.GetXML();
XML.SetXML(sUserXML);
end

return sXML
end


local function Dock_SetMemory(sPane)
tPanes[sPane].DockedMemory = {
X=tPanes[sPane].X,
Y=tPanes[sPane].Y,
Width=tPanes[sPane].Width,
Height=tPanes[sPane].Height,
Style=tPanes[sPane].Style,
};
end


local function Dock_UpdatePaneDimms(sPane)
local tPos = Window.GetPos(tPanes[sPane].Handle);
local tSize = Window.GetSize(tPanes[sPane].Handle);
tPanes[sPane].X = tPos.X;
tPanes[sPane].Y = tPos.Y;
tPanes[sPane].Width = tPos.Width;
tPanes[sPane].Height = tPos.Height;
end




function Pane.SetDocked(sPane, nDockedType, nLength, bAdjustParent)
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

	if nDockedType > -1 and nDockedType < 9 and nDockedType ~= tPanes[sPane].DockedType then
	local bIsAttached = tPanes[sPane].Attached;
	local hParent = 0;
	
		if bIsAttached then
		hParent = hApp;
		else
		hParent = hDesktopWindow;
		end
		
		if hParent ~= 0 then
		local tParentSize = Window.GetSize(hParent);
					
			if nLength > 0 then		
			
			
				if nDockedType == UNDOCKED then
				RecallDockMemory();
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				
				elseif nDockedType == DOCKED_TOP then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_RIGHT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, (tParentSize.Width - nLength - 42), 0, nLength, (tParentSize.Height - Y_DIFFERENTIAL - 4), true);				
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_BOTTOM then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_LEFT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_TOP_RIGHT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_BOTTOM_RIGHT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_BOTTOM_LEFT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				elseif nDockedType == DOCKED_TOP_LEFT then
				Dock_SetMemory(sPane);
				Window_MoveWindow(tPanes[sPane].Handle, 0, 0, tParentSize.Width, nLength, true);
				Dock_UpdatePaneDimms(sPane);
				
				end
				
			end
							
		end		
	
	end

end
end


function Pane.IsDocked(sPane)
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

	if tPanes[sPane].DockedType > 1 and tPanes[sPane].DockedType < 9 then
	
		--be sure to check dock position as well as atributes such as sizable and moveable (remove the title bar when docking)
	return true
	end
	
end

return false
end


function Pane.GetDocked(sPane)
sPane = String.Lower(sPane);

if Pane.IsValid(sPane) then

end
end