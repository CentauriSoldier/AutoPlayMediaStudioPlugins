--[[
This function allows an end user of the target
application to use external scripts without breaching
your application's security parameters. This is achieved
by including a numerically-indexed tables whose values
are the names (in string format) of the restricted methods
that may not be employed by an end-user of your application.

If the script violates your set paramters then this function
returns false and returns the name of the violating method.
Otherwise, this function returns true.
]]


--NOTE: convert this to pure lua at some point.

--[[*****====******->
     ExtScriptCheck
<-******====*******]]
function ExtScriptCheck(pFile, tFunctions)
local sFile = TextFile.ReadToString(pFile);

if tFunctions then

	for nIndex, sFunction in pairs(tFunctions) do
	local nFound = 0;
	local nLastFound = 1;
		
		repeat
		nFound = String.Find(sFile, sFunction, nLastFound, false);
		nLastFound = nFound + 1;
		local nLength = string.len(sFunction);
		
			if nFound ~= -1 then
			local nFailCount = 0;
			local sBefore = String.Mid(sFile, (nFound - 1), 1);
			local sAfter = String.Mid(sFile, (nFound + nLength), 1);
							
				if not string.find(sBefore, '%a') then
				nFailCount = nFailCount + 1;
				end
				
				if not string.find(sAfter, '%a') then
				nFailCount = nFailCount + 1;
				end
				
				if nFailCount > 1 then
				return false, sFunction
				end
				
			end
		
		until nFound == -1
						
	end

end

return true
end