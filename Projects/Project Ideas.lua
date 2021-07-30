--==============================
-- Project.SetHTTPError
--==============================
function Project.SetHTTPError(...)
IRLUA_PLUGIN_CheckNumArgs(arg,2);
local sTitle = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local sMessage = IRLUA_PLUGIN_CheckTypes(arg,2,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

if String.Replace(sTitle, " ", "", false) ~= "" and String.Replace(sMessage, " ", "", false) ~= "" then
PROJECT_HTTP_ERROR_TITLE = sTitle;
PROJECT_HTTP_ERROR_MESSAGE = sMessage;
end
end



--==============================
-- Project.UpdateExe
--==============================
function Project.UpdateExe(sWebFilePath, tNotifyRestart, nPort)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local junk1 = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


if type(nPort) ~= "number" then
nPort = 80;
end

if not HTTP.TestConnection("http://www.google.com", 20, nPort, nil, nil) then
Project.ShowConnectionError();
else
	
	local sUpdaterFile = _ExeFolder.."\\"..PROJECT_DETAILS.Title.." Updater.exe";
	if not File.DoesExist(sUpdaterFile) then
	HTTP.Download("http://www.amspublic.com/downloads/programs/updater.exe", sUpdaterFile, MODE_BINARY, 20, 80, nil, nil, nil);
	end
	
	result = File.Run(sUpdaterFile, "\"".._ExeFolder.."\\"..PROJECT_DETAILS.ExeName.."\" "..sWebFilePath.."\"", _ExeFolder, SW_SHOWNORMAL, false);

	
end

end


--tExmaple = {};
--tExmaple[1] = {};
--tExmaple[1].Local = _ExeFolder.."\\MyProject.ini";
--tExmaple[1].Web = "www.amspublic.com/downloads/MyProject.ini";
--START
--==============================
-- Project.UpdateNonExe
--==============================
function Project.UpdateNonExe(tFiles, tNotifyRestart)
IRLUA_PLUGIN_CheckNumArgs(arg,1);
local junk1 = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


end