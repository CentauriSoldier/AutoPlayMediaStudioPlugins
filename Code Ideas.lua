--=========================
-- CSG.LuaToRTF
--=========================
function CSG.LuaToRTF(...)
IRLUA_PLUGIN_CheckNumArgs(arg,3);
local sInput = IRLUA_PLUGIN_CheckTypes(arg,1,{"string"});
local tColors = IRLUA_PLUGIN_CheckTypes(arg,2,{"table"});
local nFontSize = IRLUA_PLUGIN_CheckTypes(arg,3,{"number"});
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--[[Color Order
1. Keywords
2. Operators
3. Numbers
4. Strings
5. Comments
6. Normal Text
]]
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--BEGIN | FUNCTION VARIABLES
local sNumberColor = tColors[3];
local tChars = {};
local tNumbers = {"0","1","2","3","4","5","6","7","8","9"};
tChars[1] = {"elseif ","else","if "," then","repeat ","while ","for "," in "," do","end","local ","break","return ","true","false"," not ","function"};
tChars[2] = {"+","-","*","/","^","%","(",")","{","}","[","]","=","~","<",">",",","."};
local tChunksLeft = {};
local tParts = {};
local tLines = {};
--local sTemp = String.
local sTemp = String.Replace(sInput, "\\", "\\\\", false);
local tLetters = {"a","b","c","d","e","f","g","h","i","j"};				
--END | FUNCTION VARIABLES
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--BEGIN | CREATE THE HEADER
local sHeader = [[{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 MS Shell Dlg;}}
{\colortbl ;]];
for x = 1, Table.Count(tColors) do
local tRGB = CSG.HexColorToRGB(tColors[x]);
sHeader = sHeader.."\\red"..tRGB.Red.."\\green"..tRGB.Green.."\\blue"..tRGB.Blue..";";
end
sHeader = sHeader..[[}
\viewkind4\uc1\pard\f0\fs]]..""..(nFontSize * 2).."";
--END | CREATE THE HEADER
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--BEGIN | MULTI-LINE COMMENT PROCESSING
repeat
nFoundStart = String.Find(sTemp, "--[[", 1, false);

	if nFoundStart ~= -1 then
	
	--chop off the left side off the string and pack it away
	local sChunk = String.Left(sTemp, nFoundStart - 1);
	local nNextIndex = Table.Count(tParts) + 1;
	tParts[nNextIndex] = sChunk;
	
	--store the ID of it's location so we can process it later
	tChunksLeft[Table.Count(tChunksLeft) + 1] = nNextIndex;
	
	--get the remaining right side of the string for processing next	
	sTemp = String.Right(sTemp, (String.Length(sTemp) - nFoundStart + 4));
			
		local nFoundEnd = String.Find(sTemp, "]]", 1, false);
		
		if nFoundEnd ~= -1 then
		
		--isolate the remaining part of our multiline comment from the rest of the script string
		local sComment = String.Left(sTemp, (nFoundEnd + 1));
		
		--turn carriage returns into their proper RTF text
		local tCommentLines = CSG.DelimitedStringToTable(sComment, "\r\n");
		local sFormComment = "";
		
		if tCommentLines then
			for nLine, sLine in tCommentLines do
			sFormComment = sFormComment..sLine.."\\par ";
			end
		end
		
		--now we can store this section of the string in its proper place
		tParts[Table.Count(tParts) + 1] = "\\i\\cf5 "..sFormComment.."\\cf0\\i0 ";
		
		--now we get the string that's left (if any) after our multiline comment
		sTemp = String.Right(sTemp, (String.Length(sTemp) - nFoundEnd - 1));
		end
			
	end

until nFoundStart == -1

--pack away whatever is left of the input string after the previous process
if sTemp ~= "" then
local nNextIndex = Table.Count(tParts) + 1;
tParts[nNextIndex] = sTemp;
tChunksLeft[Table.Count(tChunksLeft) + 1] = nNextIndex;
end
--END | MULTI-LINE COMMENT PROCESSING
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--BEGIN | PROCESS ALL NON-MULTI-LINE COMMENTS INTO SINGLE LINES
for nIndex, sPart in tParts do
local bIsComment = true;

	for nChunkIndex, nChunkID in tChunksLeft do
		
		if nIndex == nChunkID then
		bIsComment = false;
		break;
		end
		
	end
	
		
	if bIsComment == true then
	
	local nNextIndex = Table.Count(tLines) + 1;
	tLines[nNextIndex] = {};
	tLines[nNextIndex].Code = sPart;
	tLines[nNextIndex].IsComment = true;
	
	else

	local tChunk = CSG.DelimitedStringToTable(sPart, "\r\n");	
		
		for nLineIndex, sLine in tChunk do
		local nNextIndex = Table.Count(tLines) + 1;
		tLines[nNextIndex] = {};
		tLines[nNextIndex].Code = sLine;
		tLines[nNextIndex].IsComment = false;	
		end
	
	end

end
--END | PROCESS ALL NON-MULTI-LINE COMMENTS INTO SINGLE LINES
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function ProcessChunk(sCode)
local tStrings = {};
sChunk = sCode;	

	repeat
	nFound = String.Find(sChunk, "\"", 1, false);
		
		if nFound ~= -1 then

			local nFoundEnd = String.Find(sChunk, "\"", (nFound + 1), false);
			
			if nFoundEnd ~= -1 then
			local sStringLeft = String.Left(sChunk, (nFound - 1));
			local sStringMid = String.Mid(sChunk, nFound, nFoundEnd);
			local sStringRight = String.Right(sChunk, (String.Length(sChunk) - nFoundEnd));
			local nNextIndex = Table.Count(tStrings) + 1;
				
				if sStringLeft ~= "" then
				tStrings[nNextIndex] = {};
				tStrings[nNextIndex].Code = sStringLeft;
				tStrings[nNextIndex].IsString = false;
				nNextIndex = nNextIndex + 1;
				end
				
			tStrings[nNextIndex] = {};
			tStrings[nNextIndex].Code = "\\b\\cf4 "..sStringMid.."\\cf0\\b0 ";
			tStrings[nNextIndex].IsString = true;
			sChunk = sStringRight;

			else
			--NOTE NOTE NTOE NTEON TNOENTOE TNOETOENTOENTONETOENTOENTONTOETNEOTONTEONTENTOENTOE make the rest of the line a string if there is no end point
			nFound = -1
			end
					
		end

	until nFound == -1

--attach the remaining bit of the line to the string table
if sChunk ~= "" then
local nNextIndex = Table.Count(tStrings) + 1;
tStrings[nNextIndex] = {}
tStrings[nNextIndex].Code = sChunk;
tStrings[nNextIndex].IsString = false;
end


if tStrings then
sChunk = "";
	
	for nIndex, tString in tStrings do
				
		if tString.IsString == false then
		
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			--BEGIN | PROCESS THE NUMBERS
			for nNumID, sNumber in tNumbers do
			local sLetter = tLetters[nNumID];
			tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, sNumber, "\\cfZERO \\b\\cfONE "..sLetter.."\\cfZERO\\bZERO \\cfSIX", false);
			end
			
			tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, "\\cfZERO", "\\cf0", false);
			tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, "\\bZERO", "\\b0", false);
			tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, "\\cfSIX", "\\cf6", false);
			
			for nNumberID, sNumber in tNumbers do
			tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, "\\cfONE "..tLetters[nNumberID], "\\cf3 "..sNumber, false);
			end
			--END | PROCESS THE NUMBERS
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			
			
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			--BEGIN | PROCESS OTHER CHARACTEWRS
			
			for nColor, tTable in tChars do
									
				for nCharIndex, sItem in tTable do
				tStrings[nIndex].Code = String.Replace(tStrings[nIndex].Code, sItem, "\\cf0 \\b\\cf"..nColor.." "..sItem.."\\cf0\\b0 \\cf6 ", false);
				end
																			
			end
			--END | PROCESS THE OTHER CHARACTEWRS
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		sChunk = sChunk.."\\cf6 "..tStrings[nIndex].Code.."\\cf0 ";
		else
		sChunk = sChunk..tString.Code;
		end
		
	end	

end

return sChunk
end
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--BEGIN | SINGLE-LINE COMMENT AND NORMAL LINE PROCESSING
for nIndex, tLine in tLines do

	if tLine.IsComment == false then
	local sRTF = "";
	local nFound = String.Find(tLine.Code, "--", 1, false);
			
		if nFound ~= -1 then
		local sLineLeft = "";
		local sLineRight = "";
				
			if nFound ~= 1 then
			--split the string up into sections that are commented and not commented
			sLineLeft = String.Left(tLine.Code, (nFound - 1));
			sLineRight = String.Right(tLine.Code, (String.Length(tLine.Code) - nFound + 1));
			else
			sLineRight = tLine.Code;
			end
			
		tLines[nIndex].Code = "\\cf6 "..ProcessChunk(sLineLeft).."\\i\\cf5 "..sLineRight.."\\cf0\\i0\\cf0\\par ";
		else
			
		tLines[nIndex].Code = "\\cf6 "..ProcessChunk(tLines[nIndex].Code).."\\cf0\\par ";
		end
		
	end

end

--END | SINGLE-LINE COMMENT AND NORMAL LINE PROCESSING
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--reassemble the string and return it
local sRet = "";
for nIndex, tLine in tLines do
sRet = sRet..tLine.Code;
end

return sHeader..sRet
end