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


function IsInRectangle(sObject)
local nObjectType = -1;

if Application.GetCurrentDialog() ~= "" then
nObjectType = DialogEx.GetObjectType(sObject);
elseif Application.GetCurrentPage() ~= "" then
nObjectType = Page.GetObjectType(sObject);
end

if nObjectType ~= -1 then
local fAction = tTypes[nObjectType];	
local tPos = fAction.GetPos(sObject);
local tSize = fAction.GetSize(sObject);
local tMouse=System.GetMousePosition(true);
local nX=tMouse.X;
local nY=tMouse.Y;
	
	if (nX >= tPos.X) and (nX <= tPos.X + tSize.Width) then

		if (nY >= tPos.Y) and (nY <= tPos.Y + tSize.Height) then
		return true
		end
	
	end

end

return false
end


--[[
altered to accept the Y and Y positions sent from the 'On Mouse Move' event.
To make this work properly, embed this function in your custom function that is called during the 'On Mouse Move' event.
]]
local function IsInRectangle(sObject, e_X, e_Y)
local nObjectType = -1;

if Application.GetCurrentDialog() ~= "" then
nObjectType = DialogEx.GetObjectType(sObject);
elseif Application.GetCurrentPage() ~= "" then
nObjectType = Page.GetObjectType(sObject);
end

if nObjectType ~= -1 then
local fAction = tTypes[nObjectType];	
local tPos = fAction.GetPos(sObject);
local tSize = fAction.GetSize(sObject);

	if (e_X >= tPos.X) and (e_X <= tPos.X + tSize.Width) then

		if (e_Y >= tPos.Y) and (e_Y <= tPos.Y + tSize.Height) then
		return true
		end
	
	end

end

return false
end