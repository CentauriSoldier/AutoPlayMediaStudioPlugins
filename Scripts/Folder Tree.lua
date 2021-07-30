 
--[[
FILLS OR RESETS THE TREE STRUCTURE BY SETTING THE ROOT DIR
]]
function FillTree(strRootFolder)
	Tree.RemoveNode("tree",1);
	Tree.SetEnabled("tree",false);
	StatusDlg.Show();
	AddFolderToTree("1", strRootFolder, true);
	StatusDlg.Hide();
	Tree.SetEnabled("tree",true);
end

---------------------------------------------------------------------------------

--[[
CHECKS IF A GIVEN PATH IS A FOLDER; 
--
RETURNS TRUE IF IT IS AND FALSE IF IT ISN'T
]]
function IsFolder(strPath)
	--[[local tblAtt = File.GetAttributes(strPath);	
	if (not tblAtt) then
		return false;
	end
	
	return tblAtt.Directory;
	]]
	
	if Folder.DoesExist(strPath)==true then
		return true;
	else
		return false;
	end
end

---------------------------------------------------------------------------------

--[[
ADDS A SINGLE ITEM (FILE OR FOLDER) TO THE TREE
strNode				= TREE NODE OF THE ITEM BEING ADDED
strFilename			= FULL PATH OF THE FILE OR FOLDER
--
RETURNS THE TREE NODE OF THE ADDED ITEM OR "" IF AN ERROR HAS OCCURRED
]]
function AddFileToTree(strNode,strFilename)
	local strShortName = strFilename;
	
	local bIsFolder = IsFolder(strFilename);
	--if bIsFolder == false then
		--return "";
	--end
		
	local tlbSpliPath = String.SplitPath(strFilename);
	if (not tlbSpliPath) then
		return "";
	end
	
	local strTemp = String.TrimLeft(strFilename,"\\");
	local nFoundPos = String.ReverseFind(strTemp,"\\");
	--local nImageIndex = 0;
	--local nSelImage = 0;
	
	if (nFoundPos ~= -1) then
		local nLength = String.Length(strTemp);
		strShortName = String.Right(strTemp,nLength-nFoundPos);
	else
		strShortName = strTemp;
	end
	
	--if (bIsFolder) then
		--nImageIndex = 1;
		--nSelImage = 2;
	--end
	
	return Tree.InsertNode("tree",strNode,{Text=strShortName,Data=strFilename});
end

---------------------------------------------------------------------------------

--[[
ADDS A FOLDER TO THE TREE. THE FUNCTION CHECKS IF EACH FOLDER IS EMPTY,
AND IF IT ISN'T, ADDS A SINGLE 'DUMMY' CHILD TO THE FOLDER NODE (WITH TEXT "...").
NOTE THAT THE FUNCTION DOES NOT RECURSE INTO THE SUBFOLDERS (AS WAS IN BRETT'S CODE) -- THAT SAVES TIME DRAMATICALLY.
--
strNode				= TREE NODE OF THE ITEM BEING ADDED
strFolder			= FULL PATH OF THE FOLDER
bAddRootItem		= WHETHER THE FOLDER IS ROOT (FIRST IN THE TREE STRUCTURE)
]]
function AddFolderToTree(strNode, strFolder, bAddRootItem)
	
	if (bAddRootItem) then
		strNode = AddFileToTree(strNode, strFolder);
	end

	local nNodeCounter = 1;
		
	tblFiles = File.Find(strFolder,"*.*",false,true);
	if (tblFiles) then
		for i, strFileName in pairs(tblFiles) do		
			--bSkip = false;
			local strNodeIndex = strNode.."."..nNodeCounter;
			strNodeIndex = String.TrimLeft(strNodeIndex,".");
			
			local strAddedIndex = AddFileToTree(strNodeIndex,strFileName);
						
			if(strAddedIndex ~= "")then
			
				if (IsFolder(strFileName)) then								
					if FolderIsEmpty(strFileName) == false then
						Tree.InsertNode("tree", strAddedIndex..".1", {Text="...",Data="...",NodeIndex=strAddedIndex..".1"});						
					end
				end
			
				nNodeCounter = nNodeCounter + 1;
			end
		end
	end
end

---------------------------------------------------------------------------------

--[[
SETS THE ROOT FOLDER OF THE TREE STRUCTURE
]]
function SetRootFolder(strFolderName)
	Input.SetText("inputFolder",strFolderName);
	FillTree(strFolderName);
end

---------------------------------------------------------------------------------

--[[
CHECKS WHETHER THE GIVEN FOLDER IS EMPTY
--
RETURNS TRUE IF IT IS, FALSE IF IT ISN'T
]]
function FolderIsEmpty(sFolder)

	if IsFolder(sFolder) == false then
		return true;
	end
	
	local tbFiles = File.Find(sFolder, "*.*", false, true, nil, nil);
	if (not tbFiles) then
		return true;
	end
	
	if Table.Count(tbFiles) == 0 then
		return true;
	else
		return false;
	end
	
end





--Tree->On Expanded
 
local nInd = e_NodeIndex;

if (nInd ~= "1") and (e_Expanded == true) then -- if it isn't the root dir and is expanded
	local sTextDummy = Tree.GetNode("tree", nInd..".1").Text; -- text of the first child
	local tbData = Tree.GetNode("tree", nInd); -- properties of this node
	 
	if sTextDummy == "..." then -- if the node has never been expanded...
		Tree.RemoveNode(this, nInd..".1"); -- delete the dummy child 
		AddFolderToTree(nInd, tbData.Data, false); -- reconstruct the folder structure
	end	
end

