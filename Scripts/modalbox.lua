ModalBox = {}

local MODALDARK = [[iVBORw0KGgoAAAANSUhEUgAAACUAAAAjCAIAAACcpVRJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAApSURBVFhH7dAxAQAAAMKg9U9tBn+IQGHAgAEDBgwYMGDAgAEDBgy8AwMPUAAB600fHQAAAABJRU5ErkJggg==]];

function ModalBox.Create(Dialog, Opacity, Speed)

	Crypto.Base64DecodeFromString(MODALDARK, _TempFolder.."\\MBD.tmp");
	Page.CreateObject(OBJECT_IMAGE, "modalbox", {ImageFile=_TempFolder.."\\MBD.tmp", Enabled=false, Visible=false, X=0, Y=0});

	OBJECTS = Page.EnumerateObjects();
	for i, o in pairs(OBJECTS) do
	TYPE = Page.GetObjectType(o);
	if TYPE == OBJECT_FLASH then
	Flash.SetVisible(o, false);
	elseif TYPE == OBJECT_PLUGIN then
	Plugin.SetVisible(o, false);
	elseif TYPE == OBJECT_COMBOBOX then
	ComboBox.SetVisible(o, false);
	elseif TYPE == OBJECT_COMBOBOX then
	ComboBox.SetVisible(o, false);
	elseif TYPE == OBJECT_INPUT then
	Input.SetVisible(o, false);
	elseif TYPE == OBJECT_PROGRESS then
	Progress.SetVisible(o, false);
	elseif TYPE == OBJECT_RADIOBUTTON then
	RadioButton.SetVisible(o, false);
	elseif TYPE == OBJECT_LISTBOX then
	ListBox.SetVisible(o, false);
	elseif TYPE == OBJECT_WEB then
	Web.SetVisible(o, false);
	elseif TYPE == OBJECT_TREE then
	Tree.SetVisible(o, false);
	elseif TYPE == OBJECT_CHECKBOX then
	CheckBox.SetVisible(o, false);
	elseif TYPE == OBJECT_GRID then
	Grid.SetVisible(o, false);
	end
	end
	
	Image.SetSize("modalbox", Window.GetSize(Application.GetWndHandle()).Width, Window.GetSize(Application.GetWndHandle()).Height);
	Image.SetOpacity("modalbox", 0);
	Image.SetVisible("modalbox", true);
	repeat
	Image.SetOpacity("modalbox", Image.GetOpacity("modalbox")+Speed);
	until Image.GetOpacity("modalbox") == Opacity
	SHOW_DIALOG = DialogEx.Show(Dialog, true, nil, nil);
	repeat
	Image.SetOpacity("modalbox", Image.GetOpacity("modalbox")-Speed);
	until Image.GetOpacity("modalbox") == 0
	Image.SetVisible("modalbox", false);
	
	OBJECTS = Page.EnumerateObjects();
	if OBJECTS ~= nil then
	for i, o in pairs(OBJECTS) do
	TYPE = Page.GetObjectType(o);
	if TYPE == OBJECT_FLASH then
	Flash.SetVisible(o, true);
	elseif TYPE == OBJECT_PLUGIN then
	Plugin.SetVisible(o, true);
	elseif TYPE == OBJECT_COMBOBOX then
	ComboBox.SetVisible(o, true);
	elseif TYPE == OBJECT_INPUT then
	Input.SetVisible(o, true);
	elseif TYPE == OBJECT_PROGRESS then
	Progress.SetVisible(o, true);
	elseif TYPE == OBJECT_RADIOBUTTON then
	RadioButton.SetVisible(o, true);
	elseif TYPE == OBJECT_LISTBOX then
	ListBox.SetVisible(o, true);
	elseif TYPE == OBJECT_WEB then
	Web.SetVisible(o, true);
	elseif TYPE == OBJECT_TREE then
	Tree.SetVisible(o, true);
	elseif TYPE == OBJECT_CHECKBOX then
	CheckBox.SetVisible(o, true);
	elseif TYPE == OBJECT_GRID then
	Grid.SetVisible(o, true);
	end
	end
	end
	ModalBox.Cleanup();
	return SHOW_DIALOG
end

function ModalBox.Cleanup()
	if File.DoesExist(_TempFolder.."\\MBD.tmp") then
	File.Delete(_TempFolder.."\\MBD.tmp", false, false, true, nil);
	end
end
