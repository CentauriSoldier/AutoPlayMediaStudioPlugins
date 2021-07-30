IPC = {};
tChannels = {};


function IPC.Initilaize()
if not Memory then
Application.LoadActionPlugin(_Plugins.."\\IPC\\IPC.dll");
end
end



function IPC.JoinChannel(sChannel)


end





IPC.Initilaize()



local tPqweqwerops = {
	Attached = false,	
	DetachToHere = false,
	DockedType = UNDOCKED,
	Enabled = false,
	Persist = true,
	Sizeable = true,
	Title = "Hello",
	TitleBar = true,
	Visible = false,
	X=10000,--50,
	Y=10000,--50,
	ExtX=10000,--1850,
	ExtY=10000,--50,
	Width=0,--250,
	Height=0,--400,
	ExtWidth=0,--800,
	ExtHeight=0,--600,	
	};

local sSlaveWindowTitle = "Hello";
local hSlaveWindow = 0;
local sLastSentString = "";


function GetSlaveWndHandle(sTitle)
local vArgs = string.format("%s,\"%s\"","null",sTitle);
hWnd = String.ToNumber(DLL.CallFunction(_SystemFolder.."\\User32.dll", "FindWindowA", vArgs, DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL));

if hWnd ~= 0 then
hSlaveWindow = hWnd;
return true
end

return false
end





function SendString(sText)
if not Window_IsWindow(hSlaveWindow) then
	
	if GetSlaveWndHandle(sSlaveWindowTitle) == false then
	GetSlaveWndHandle(sLastSentString);
	end
		
end

sLastSentString = sText;

local vArgs = string.format("%d,%d,\"%s\",\"%s\"",
							hSlaveWindow, Math.HexToNumber("0x000C"),"",sText);
DLL.CallFunction(_SystemFolder.."\\User32.dll", "SendMessageA", vArgs, DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL)
end



function GetString(nChars)
local nMaxChars = 128;

if type(nChars) == "number" then

	if nChars > 1 then
	nMaxChars = nChars;
	end

end


local nBytes = (nMaxChars + 1) * 8;
local mBuffer = Memory.Allocate(nBytes);

--Paragraph.SetText("Paragraph1", mBuffer);

local vArgs = string.format("%d,%d,%d,%d",
							hSlaveWindow, Math.HexToNumber("0x000D"),nMaxChars,mBuffer);
local nCharsCopied = String.ToNumber(DLL.CallFunction(_SystemFolder.."\\User32.dll", "SendMessageA", vArgs, DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL));

local sTitle = Memory.GetString(mBuffer, -1, "Ascii");
Memory.Free(mBuffer);

--return "Characters Copied: "..nCharsCopied.."\r\nBuffer ID:"..mBuffer.."\r\nTitle: "..sTitle
return sTitle or ""
end