function GetPluginXMLFromLMD(strPath)
  local memPx = Memory.Allocate(1024);
  local memSz = Memory.Allocate(8);
  Memory.PutInt(memSz, 1024);
  
  local ret = tonumber(DLL.CallFunction(strPath, "irPlg_GetPluginActionXML", memPx..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL))
  
  if ret == -1 then
    local require_size = Memory.GetInt(memSz)
    memPx = Memory.ReAllocate(memPx, require_size);
    DLL.CallFunction(strPath, "irPlg_GetPluginActionXML", memPx..","..memSz, DLL_RETURN_TYPE_INTEGER, DLL_CALL_CDECL);
  end
  
  local strPluginXML =  Memory.GetString(memPx, -1);
  Memory.Free(memSz);
  Memory.Free(memPx);
  return strPluginXML;
end