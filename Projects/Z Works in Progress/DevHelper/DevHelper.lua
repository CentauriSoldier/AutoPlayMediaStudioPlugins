DevHelper = {};
local hIDEWindow = 0;

function DevHelper.GetIDEHandle()
return hIDEWindow
end

function DevHelper.OnStartup(sProjectName)
local vArgs = string.format("%s,\"%s\"",
							"null", sProjectName..".autoplay - AutoPlay Media Studio");
local hIDE = DLL.CallFunction(_SystemFolder.."\\User32.dll", "FindWindowA", vArgs, DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL);

if type(hIDE) == "string" then

	if String.Replace(hIDE, " ", "", false) ~= "" then
	hIDE = tonumber(hIDE);
		
		if hIDE ~= 0 then
		hIDEWindow = hIDE;
		Window.Minimize(hIDE);
		end
	
	else
	hIDE = 0;	
	end
	
end

end



function DevHelper.OnShutdown()
local hIDE = DevHelper.GetIDEHandle();

if hIDE ~= 0 then
Window.Restore(hIDE);
end

end