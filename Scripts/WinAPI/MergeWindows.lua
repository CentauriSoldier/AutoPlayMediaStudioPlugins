function MergeWindows(tParent, tChild)

local hParent = WinApi.FindWindow(tParent.Class, tParent.Title);
local hChild = WinApi.FindWindow(tChild.Class, tChild.Title);

if hParent ~= 0 and hChild ~= 0 then
WinApi.ShowWindow(hParent, SW_HIDE);
WinApi.ShowWindow(hChild, SW_HIDE);

local tParentRect = WinApi.GetClientRect(hParent);
WinApi.SetParent(hChild, hParent);
WinApi.SetWindowLong(hChild, GWL_STYLE, WS_CHILD.."|"..WS_VISIBLE, false);

WinApi.MoveWindow(hChild, tParentRect.Left, tParentRect.Top, tParentRect.Right - tParentRect.Left, tParentRect.Bottom - tParentRect.Top, true);
WinApi.ShowWindow(hParent, SW_SHOW);
WinApi.ShowWindow(hChild, SW_SHOW);



elseif hParent ~= 0 and hChild == 0 then
Dialog.Message("Error", "Child window not found.");
elseif hParent == 0 and hChild ~= 0 then
Dialog.Message("Error", "Parent window not found.");
elseif hParent == 0 and hChild == 0 then
Dialog.Message("Error", "Niether window was found.");
end
end