function GetPluginNameFromLMD(strPath)

  memPn = Memory.Allocate(1024); -- memory for store plugin name
  memSz = Memory.Allocate(8); -- memory for store memPn size
  Memory.PutInt(memSz, 1024); -- Size of memPn
  --Memory.PutString(memPn, "", -1); all memory have null value dont need this line


  --ret = tonumber(DLL.CallFunction(strPath, "irPlg_GetPluginActionXML", memPn..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL))
  ret = tonumber(DLL.CallFunction(strPath, "irPlg_GetPluginName", memPn..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL))
  
  if ret == -1 then -- size of memPn is not enough so dll fill the require size in memSz
    require_size = Memory.GetInt(memSz) -- get the require size that dll filled it
    memPn = Memory.ReAllocate(memPn, require_size); -- reallocate memPn with require size
    --ret = tonumber(DLL.CallFunction(strPath, "irPlg_GetPluginActionXML", memPn..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL))
    DLL.CallFunction(strPath, "irPlg_GetPluginName", memPn..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL);
  end
  
  local strPluginName =  Memory.GetString(memPn, -1); -- get the plugin name
  Memory.Free(memSz); -- release memory on ram of memSz
  Memory.Free(memPn); -- release memory on ram of memPn
  return strPluginName; -- return :)
end