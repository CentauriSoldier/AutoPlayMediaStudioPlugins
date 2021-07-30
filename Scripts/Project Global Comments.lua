--||||||||||||||||||||||||||||||||||||||||||||||||||>>>
-- BEGIN | PROJECT SETTINGS
-->>>+++++++++++++++++++++>
Project.Initialize("", "Centauri Soldier", "AMSPublic", "www.AMSPublic.org", "CentauriSoldier@AMSPublic.org", "Copyright © 2010 AMSPublic.org", "Free to use and distribute", ".exe", ".ico", _ExeFolder.."\\.psad", "");
_sVersion = Project.ProcessVersion("", 4, 9);
_bIsCompiled = Project.IsCompiled();
local tCLAs = {
{"",[[
]]},
};
Project.SetCLAs(tCLAs);
--<-------------------<<<
-- END | PROJECT SETTINGS
--<----------------------------------------<<<
--|
--|
--|
--|
--||||||||||||||||||||||||||||||||||||||||||||||||||>>>
-- BEGIN | GLOBAL PATHS
-->>>+++++++++++++++++>

--<---------------<<<
-- END | GLOBAL PATHS
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--|
--|
--|
--|
--||||||||||||||||||||||||||||||||||||||||||||||||||>>>
-- BEGIN | GLOBAL VARIABLES
-->>>+++++++++++++++++++++>

--<-------------------<<<
-- END | GLOBAL VARIABLES
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--|
--|
--|
--|
--||||||||||||||||||||||||||||||||||||||||||||||||||>>>
-- BEGIN | GLOBAL ACTIONS
-->>>+++++++++++++++++++>

--<-----------------<<<
-- END | GLOBAL ACTIONS
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--|
--|
--|
--|
--||||||||||||||||||||||||||||||||||||||||||||||||||>>>
-- BEGIN | GENERAL FUNCTIONS
-->>>++++++++++++++++++++++>

--<--------------------<<<
-- END | GENERAL FUNCTIONS
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--|
--|
--|
--|
--=============================================================>>>>>>>>>>>>
-- BEGIN | APPLICATION MENU
---------------------------------------------------------------
function ShowMainMenu()
local sTitle = Project.GetDetails().Title;
local sAuthor = Project.GetDetails().Author;
local sCompany = Project.GetDetails().Company;

--======================================================
tMainMenuCode = {
["Main Menu"] = {
------------------------------------>>
--===========>>>>>>>>>>>>>####
["&File|Exit"] = [[
Project.Shutdown();
Application.Exit(0);
]],
--===========>>>>>>>>>>>>>####
["&Help|Help"] = [[

]],
--===========>>>>>>>>>>>>>####
["&Help|Visit "..sCompany] = [[
File.OpenURL(Project.GetDetails().Website, SW_SHOWNORMAL);
]],
--===========>>>>>>>>>>>>>####
["&Help|Contact "..sAuthor] = [[
File.OpenEmail(Project.GetDetails().Email.."?Subject="..Project.GetDetails().Title, SW_SHOWNORMAL);
]],
--===========>>>>>>>>>>>>>####
["&Help|About "..sTitle] = [[
Project.ShowAbout();
]],
------------------------------------<<
				},
};
--======================================================

Menu.SetActive("Main Menu");

-- File menu
Menu.SetItem("&File|Exit", 0, true, false, tMainMenuCode["Main Menu"]["&File|Exit"], true);

--Help Menu
--Menu.SetItem("&Help|Help", 0, true, false, tMainMenuCode["Main Menu"]["&Help|Help"], true);
--Menu.SetItem("&Help|---", 0, true, false, "", true);
Menu.SetItem("&Help|Visit "..sCompany, 0, true, false, tMainMenuCode["Main Menu"]["&Help|Visit "..sCompany], true);
Menu.SetItem("&Help|Contact "..sAuthor, 0, true, false, tMainMenuCode["Main Menu"]["&Help|Contact "..sAuthor], true);
Menu.SetItem("&Help|---", 0, true, false, "", true);
Menu.SetItem("&Help|About "..sTitle, 0, true, false, tMainMenuCode["Main Menu"]["&Help|About "..sTitle], true);
end
---------------------------------------------------------------
-- END | APPLICATION MENU
--=============================================================<<<<<<<<<<<<



--[[*******===*******->
       MyFunction
<-*********===*******]]