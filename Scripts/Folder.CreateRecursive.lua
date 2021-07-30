function Folder.CreateRecursive(pFolder)
local tPaths = {
	[1] = pFolder,
};
local sPath = pFolder;
local nFound = 0;

repeat
nFound = String.ReverseFind(sPath, "\\", false);
	
	if nFound ~= -1 then
	sPath = String.Left(sPath, nFound - 1);	
	table.insert(tPaths, 1, sPath);
	end

until nFound == -1

if tPaths then

	for nIndex, pFolder in pairs(tPaths) do
		
		if not Folder.DoesExist(pFolder) then
		Folder.Create(pFolder);
		end
		
	end

end

end