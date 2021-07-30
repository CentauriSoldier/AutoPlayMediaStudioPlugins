--TODO should this be 10 due to the nil at arg 11?
--TODO Remove the global paths check expect for the AAA.Require() function.
--==============================
-- Project.Initialize
--==============================
function Project.Initialize(...)
	AAA.CheckCount("Project", "Initialize", arg, 11); 
	local sTitle = AAA.CheckTypes("Project", "Initialize", arg, 1, {"string"});
	local sAuthor = AAA.CheckTypes("Project", "Initialize", arg, 2, {"string"});
	local sCompany = AAA.CheckTypes("Project", "Initialize", arg, 3, {"string"});
	local sWebsite = AAA.CheckTypes("Project", "Initialize", arg, 4, {"string"});
	local sEmail = AAA.CheckTypes("Project", "Initialize", arg, 5, {"string"});
	local sCopyright = AAA.CheckTypes("Project", "Initialize", arg, 6, {"string"});
	local sLicense = AAA.CheckTypes("Project", "Initialize", arg, 7, {"string"});
	local sExeName = AAA.CheckTypes("Project", "Initialize", arg, 8, {"string"});
	local sIconFile = AAA.CheckTypes("Project", "Initialize", arg, 9, {"string"});
	local sDataFile = AAA.CheckTypes("Project", "Initialize", arg, 10, {"string"});
	local sDataFolder = AAA.CheckTypes("Project", "Initialize", arg, 11, {"string"});
	local sLogoFile = AAA.CheckTypes("Project", "Initialize", arg, 12, {"string", "nil"});
	
	if type(GLOBAL_PATHS_DATA_FOLDER) == "nil" then
		
		if Project.StringIsBlank(sDataFolder) then
		GLOBAL_PATHS_DATA_FOLDER = "AutoPlay";
		end

		local sDataFolder = GLOBAL_PATHS_DATA_FOLDER;
		
		
		if Table.Count(_CommandLineArgs) == 0 then
		
		_ExeFolder = _SourceFolder;
		local sDataPath = _SourceFolder.."\\"..sDataFolder;
		_Audio = sDataPath.."\\Audio";
		_Buttons = sDataPath.."\\Buttons";
		_DLLs = sDataPath.."\\DLLs";
		_Docs = sDataPath.."\\Docs";
		_Flash = sDataPath.."\\Flash";
		_Fonts = sDataPath.."\\Fonts";
		_Icons = sDataPath.."\\Icons";
		_Images = sDataPath.."\\Images";
		_Plugins = sDataPath.."\\Plugins";
		_Scripts = sDataPath.."\\Scripts";
		_TempAPFolder = sDataPath.."\\Temp";
		_Videos = sDataPath.."\\Videos";
		sDataPath = "_"..sDataFolder..[[ = ]].."\"".._SourceFolder.."\\"..sDataFolder.."\"";
		sDataPath = String.Replace(sDataPath, "\\", "\\\\", false);
		loadstring(sDataPath)();
		
		elseif Table.Count(_CommandLineArgs) > 0 then 
		
		sSourcePath = _CommandLineArgs[Table.Count(_CommandLineArgs)];
		nSourcePathFound = String.Find(sSourcePath, "SFXSOURCE:", 1, false);
		
			if nSourcePathFound ~= -1 then
			sTempPath = String.Replace(sSourcePath, "SFXSOURCE:", "", false);
			
				for x = 1, 2 do
				nFolderLength = String.Length(sTempPath);
				nErasePoint = String.ReverseFind(sTempPath, "\\", false);
				sTempExeFolder = String.Left(sTempPath, nFolderLength - (nFolderLength - nErasePoint) - 1);
				end
			
				_ExeFolder = sTempExeFolder;
				local sDataPath = sDataFolder;
				_Audio = sDataPath.."\\Audio";
				_Buttons = sDataPath.."\\Buttons";
				_DLLs = sDataPath.."\\DLLs";
				_Docs = sDataPath.."\\Docs";
				_Flash = sDataPath.."\\Flash";
				_Fonts = sDataPath.."\\Fonts";
				_Icons = sDataPath.."\\Icons";
				_Images = sDataPath.."\\Images";
				_Plugins = sDataPath.."\\Plugins";
				_Scripts = sDataPath.."\\Scripts";
				_Videos = sDataPath.."\\Videos";
				sDataPath = "_"..sDataFolder..[[ = ]].."\""..sDataFolder.."\"";
				sDataPath = String.Replace(sDataPath, "\\", "\\\\", false);
				loadstring(sDataPath)();
		
				
			elseif nSourcePathFound == -1 then
			_ExeFolder = _SourceFolder;
			local sDataPath = _SourceFolder.."\\"..sDataFolder;
			_Audio = sDataPath.."\\Audio";
			_Buttons = sDataPath.."\\Buttons";
			_DLLs = sDataPath.."\\DLLs";
			_Docs = sDataPath.."\\Docs";
			_Flash = sDataPath.."\\Flash";
			_Fonts = sDataPath.."\\Fonts";
			_Icons = sDataPath.."\\Icons";
			_Images = sDataPath.."\\Images";
			_Plugins = sDataPath.."\\Plugins";
			_Scripts = sDataPath.."\\Scripts";
			_Videos = sDataPath.."\\Videos";
			sDataPath = "_"..sDataFolder..[[ = ]].."\"".._SourceFolder.."\\"..sDataFolder.."\"";
			sDataPath = String.Replace(sDataPath, "\\", "\\\\", false);
			loadstring(sDataPath)();
			end
			
		end
		
	end

	if sLogoFile then
		
		if File.DoesExist(sLogoFile) then
		PROJECT_LOGO_FILE = sLogoFile;
		end
		
	end


	if Project.StringIsBlank(sTitle) then
	sTitle = "Project";
	end

	PROJECT_DETAILS.Title = sTitle;
	PROJECT_DETAILS.Author = sAuthor;
	PROJECT_DETAILS.Company = sCompany;
	PROJECT_DETAILS.Website = sWebsite;
	PROJECT_DETAILS.Email = sEmail;
	PROJECT_DETAILS.Copyright = sCopyright;
	PROJECT_DETAILS.License = sLicense;

	if File.DoesExist(_ExeFolder.."\\"..sExeName) then
	PROJECT_DETAILS.ExeName = sExeName;
	elseif File.DoesExist(_ExeFolder.."\\autorun.exe") then
	PROJECT_DETAILS.ExeName = "autorun.exe";
	else
	local tEXEs = File.Find(_ExeFolder.."\\", "*.exe", false, false, nil, nil);

		if tEXEs then
			
			if #tEXEs == 1 then
			local tParts = String.SplitPath(tEXEs[1]);
			PROJECT_DETAILS.ExeName = tParts.Filename..tParts.Extension;
			else
			ERROR("Project.Initialize", "The file assigned to the 'ExeName' variable does not exist.")
			end
			
		else
		ERROR("Project.Initialize", "The file assigned to the 'ExeName' variable does not exist.")
		end

	end

	PROJECT_DETAILS.IconFile = sIconFile;

	if not Project.StringIsBlank(sDataFile) then
	_DataFile = sDataFile;
	end

	if Project.StringIsBlank(_DataFile) then

		if Drive.GetType(String.SplitPath(_ExeFolder).Drive) == DRIVE_FIXED then
		_DataFile = _ExeFolder.."\\"..sTitle..".psad";
		else
		_DataFile = _WindowsFolder.."\\"..sTitle..".psad";
		end
		
	end

	StoreXML();

	local sCurrentCrash = XML.GetAttribute(tXMLPaths.StartUpAndShutDown, "currentcrash");

	if Project.StringIsBlank(sCurrentCrash) then
	sCurrentCrash = "false";
	end

	XML.SetAttribute(tXMLPaths.StartUpAndShutDown, "lastcrash", sCurrentCrash);
	XML.SetAttribute(tXMLPaths.StartUpAndShutDown, "currentcrash", "true");

	RestoreXML();
end