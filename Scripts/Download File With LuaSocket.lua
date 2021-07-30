function EvaluateURL(sURL)
	local r, c, h = http.request{url=sURL, method="HEAD"};
	if r == 1 and c == 307 and h and type(h.location) == "string" then--it's a redirect url and the real file link is at h.location 8-)
		return EvaluatedURL(h.location);
	elseif r == 1 and c==200 and h["accept-ranges"] == "bytes" then--it's a direct file url
		return true, sURL, tonumber(h["content-length"]);
	elseif r==1 and c==404 then
		return false, "Error: "..c;
	else
		return false, "Error: "..c;
	end
end
function GetFilename(sURL)
	local k = String.ReverseFind(sURL, "/", false);
	return (k ~= -1) and (string.sub(sURL, k+1, -1)) or "nofile";
end
function fExists(sPath, sFile, nSize, bAuto)
	if File.DoesExist(sPath.."\\"..sFile) then
		local sFSize = File.GetSize(sPath.."\\"..sFile);
		if nSize > sFSize and bAuto then --File is incomplete so we resume the download
			return true, sPath.."\\"..sFile, 'w+b';
		elseif nSize > sFSize and not bAuto then --User doesn't want to autoresume the download
			return false, "You don't want to resume the download";
		elseif nSize == sFSize then--Creates a new copy
			local nF, nG = string.find(sFile, ".+%.")
			if nF then
				sFile = string.sub(sFile, 1, nG-1).."[1]"..string.sub(sFile,nG,-1)
				local x = 2;
				while File.DoesExist(sPath.."\\"..sFile) do--Well, we have to autorename download file to a valid new name verifying that the new name doesn't exist
					if x <= 10 then
						sFile = string.sub(sFile, 1, nG-1).."["..x.."]"..string.sub(sFile,nG+3,-1);
					else
						sFile = string.sub(sFile, 1, nG-1).."["..x.."]"..string.sub(sFile,nG+2+#(tostring(x)),-1);
					end
					x=x+1;
				end
				return true, sPath.."\\"..sFile, 'wb';
			else
				return false, "No file downloaded";
			end
		elseif nSize < sFSize and bAuto then--Overwrite the existing file
			return true, sPath.."\\"..sFile, 'wb';
		elseif nSize < sFSize and not bAuto then
			local ansContinue = Dialog.Message("File already exists", "Do you want to download another copy of the file?", MB_YESNOCANCEL, MB_ICONQUESTION, MB_DEFBUTTON1);
			if ansContinue == IDYES then
				local tAns = Dialog.FileBrowse(false, "Save as", sPath, "All Files (*.*)|*.*|", "", "dat", false, false);
				if tAns and tAns[1] ~= "CANCEL" then
					return true, tAns[1], 'wb';
				else
					return false, "No file downloaded";
				end
			else
				return false, "Download cancelled";
			end
		end
	else
		return true, sPath.."\\"..sFile, 'wb';
	end
end
-------/////////
function DownloadFile(sURL, sDownloadPath, bResumeOverwrite)
	local sPath = (sDownloadPath and Folder.DoesExist(sDownloadPath)== true) and sDownloadPath or _SourceFolder.."\\Downloads";--The last one is our default download folder, but you can change it
	local sFileHandler = "";
	local bAuto = (type(bResumeOverwrite) == "boolean") and bResumeOverwrite or false;
	local bPassed, nURL, nSize = EvaluateURL(sURL);
	if not bPassed then return false end
	local sFile = GetFilename(sURL);
	if sFile == "no file" then return false end
	local bPassed, sFullPath, bMode = fExists(sPath, sFile, nSize, bAuto);
	if not bPassed then return false end
	sFileHandler = io.open(sFullPath, bMode);
	local tHeaders = {["Useragent"]='Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11', ["Accept-Encoding"]="gzip,deflate", ["Connection"]="Keep-Alive"};
	local ret, cod, hea = http.request{method = "GET", headers = tHeaders, url = sURL, redirect = true, sink = ltn12.sink.file(sFileHandler)}
end



DownloadFile("http://anyurl.com/anyfile.mp3", nil, true)