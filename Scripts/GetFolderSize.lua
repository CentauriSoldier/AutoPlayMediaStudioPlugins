function GetFolderSize(FolderName)
	fso = luacom.CreateObject("Scripting.FileSystemObject");
	folderOb = fso:GetFolder(FolderName);
	local Size = folderOb.size;
	
	fso = nil;
	folderOb = nil;
	
	return Size;
end
