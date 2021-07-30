-- Created By AMSWaves
-- GetFileNameFromHandle For Obtaining a filename from a file handle
-- work with Windows2000+

function GetFileNameFromHandle(hFile)

  pszFilename = Memory.Allocate(261)

  -- Create a file mapping object.
  hFileMap = tonumber(DLL.CallFunction("kernel32.dll", "CreateFileMappingA", hFile..", 0, 2, 0, 1, 0", DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL))
  if (hFileMap) then

    -- Create a file mapping to get the file name.
    pMem = tonumber(DLL.CallFunction("kernel32.dll", "MapViewOfFile", hFileMap..", 4, 0, 0, 1", DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL))
		if pMem then
			process = tonumber(DLL.CallFunction("kernel32.dll", "GetCurrentProcess", "", DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL))
			if DLL.CallFunction("psapi.dll", "GetMappedFileNameA", process..", "..pMem..", "..pszFilename..", 260", DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL) then
				ret = Memory.GetString(pszFilename, -1, "Ascii")
				
				drv = Memory.Allocate(25)
				devname = Memory.Allocate(260)
				
				for i=0, 25 do
					Memory.PutString(drv, String.Char(65 + i)..":", -1, "Ascii")
					if tonumber(DLL.CallFunction("kernel32.dll", "QueryDosDeviceA", drv..", "..devname..", 260", DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL)) ~= 0 then
						if String.Find(ret, Memory.GetString(devname, -1, "Ascii"), 1, false) ~= -1 then
							ret = String.Replace(ret, Memory.GetString(devname, -1, "Ascii"), String.Char(65 + i)..":", false)
						  break
						end
					end
				end
				
				Memory.Free(drv)
				Memory.Free(devname)
						
			end
      DLL.CallFunction("kernel32.dll", "UnmapViewOfFile", pMem, DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL)
		end		
		DLL.CallFunction("kernel32.dll", "CloseHandle", hFileMap, DLL_RETURN_TYPE_LONG, DLL_CALL_STDCALL)
  end

	Memory.Free(pszFilename)	
	return ret
end