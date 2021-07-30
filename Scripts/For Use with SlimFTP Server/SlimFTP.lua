SlimFTP = {};
local tSlimFTP = {
	BindInterface = "All",
	BindPort = 21,
	CommandTimeout = 300,
	ConnectTimeout = 15,	
	MaxConnections = 20,	
	ExePath = "",
	IsSetup = false,
	RepoFolder = _ExeFolder.."\\Repos",
};


--[[
TODO

Allow more configuraion options on init through Repo.ini

]]
--=============================================================>>>>>>>>>>>>
-- BEGIN | LOCAL FUNCTIONS
---------------------------------------------------------------



--[[*******==========*******->
     SlimFTP_WriteConfigFile
<-*********==========*******]]
local function SlimFTP_WriteConfigFile(pRepoFolder, sClient)
StatusBar.SetStatus("Writing SlimFTP config file...");
local pConfig = SlimFTP.GetPath().."\\slimftpd.conf";

TextFile.WriteFromString(pConfig, "", false);
Application.Sleep(400);

if not Folder.DoesExist(pRepoFolder) then
Folder.Create(pRepoFolder);
Application.Sleep(400);
else

local sConfig = [[
BindInterface ]]..tSlimFTP.BindInterface..[[

BindPort ]]..tSlimFTP.BindPort..[[

CommandTimeout ]]..tSlimFTP.CommandTimeout..[[

ConnectTimeout ]]..tSlimFTP.ConnectTimeout..[[

MaxConnections ]]..tSlimFTP.MaxConnections..[[

LookupHosts Off
<User "repo">
Password "abc123"

Mount / "]]..String.Replace(pRepoFolder, "\\", "\\\\", false)..[["
Allow / All
#Allow / Read List
</User>
]];

TextFile.WriteFromString(pConfig, sConfig, false);
end

end



--[[*******=======*******->
     SlimFTP_GetProcessID
<-*********=======*******]]
local function SlimFTP_GetProcessID()
local tProccesses = System.EnumerateProcesses();

if tProccesses then
	
	for nPID, pFile in pairs(tProccesses) do
		
		if string.lower(pFile) == string.lower(SlimFTP.GetPath().."\\SlimFTPd.exe") then
		return nPID
		end
		
	end
	
end

return -1
end



---------------------------------------------------------------
-- END | LOCAL FUNCTIONS
--=============================================================<<<<<<<<<<<<
--|
--|
--|
--|
--=============================================================>>>>>>>>>>>>
-- BEGIN | GLOBAL FUNCTIONS
---------------------------------------------------------------



--[[*******==*******->
     SlimFTP.GetPath
<-*********==*******]]
function SlimFTP.GetPath()
return tSlimFTP.Path
end



--[[******=******->
     SlimFTP.Init
<-********=******]]
function SlimFTP.Init(pFolder)
local bContinue = false;

if Folder.DoesExist(tSlimFTP.RepoFolder) then
bContinue = true;

else
Folder.Create(tSlimFTP.RepoFolder);
	
	if Folder.DoesExist(tSlimFTP.RepoFolder) then
	bContinue = true;
	end
	
end

if bContinue then
pFolder = String.TrimRight(pFolder, "\\");
local pFile = pFolder.."\\SlimFTPd.exe";

	if File.DoesExist(pFile) then
	
	tSlimFTP.Path = pFolder;
	
	local tProcesses = System.EnumerateProcesses()
	tSlimFTP.IsSetup = true;
	return true
	end
	
end

return false
end



--[[*******====*******->
     SlimFTP.IsRunning
<-*********====*******]]
function SlimFTP.IsRunning()
local tProccesses = System.EnumerateProcesses();

if tProccesses then
	
	for nPID, pFile in pairs(tProccesses) do
		
		if string.lower(pFile) == string.lower(SlimFTP.GetPath().."\\SlimFTPd.exe") then
		return true
		end
		
	end
	
end

return false
end



--[[*******=******->
     SlimFTP.Start
<-*********=******]]
function SlimFTP.Start(pRepoFolder)
if tSlimFTP.IsSetup then
local bStopped = true;

	if SlimFTP.IsRunning() then
	bStopped = SlimFTP.Stop();
	end
	
	if bStopped then
	SlimFTP_WriteConfigFile(pRepoFolder, HTTP.Submit(tRepo.PHPPath, {phpli=Crypto.MD5DigestFromString("s*a"..Dec(tRepo.Login.PHP.UN).."g#w!"),phppw=Crypto.MD5DigestFromString("l^c"..Dec(tRepo.Login.PHP.PW).."t&o!"),command="getclient"}, SUBMITWEB_GET, 20, 80, nil, nil))
	local nCode = File.Run(SlimFTP.GetPath().."\\SlimFTPd.exe", "", pRepoFolder, SW_SHOWNORMAL, false);
	Application.Sleep(500);
		
		if nCode == 1045 then
		StatusBar.SetStatus("SlimFTP server error: you do not have sufficient privileges to start SlimFTP server. Please log in as an administrator to continue.");
		return false
		
		else

			if SlimFTP.IsRunning() then
			return true	
			
			else
			StatusBar.SetStatus("SlimFTP server error: server failed to start.");
			return false
			
			end
				
		end
				
	else
	StatusBar.SetStatus("SlimFTP server error: server is already running and could not be stopped.");
		
	end

end

return false
end



--[[******=******->
     SlimFTP.Stop
<-********=******]]
function SlimFTP.Stop()
TextFile.WriteFromString(SlimFTP.GetPath().."\\slimftpd.log", "", false);
return System.TerminateProcess(SlimFTP_GetProcessID());
end
---------------------------------------------------------------
-- END | GLOBAL FUNCTIONS
--=============================================================<<<<<<<<<<<<