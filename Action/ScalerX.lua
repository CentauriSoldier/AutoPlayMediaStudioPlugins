local Application = Application;

local _nBuildWidth = 0;
local _nBuildHeight = 0;
local _nDisplayWidth = 0;
local _nDisplayHeight = 0;
local _nFontCo = 0;
local _nXHorCo = 0;
local _nYVerCo = 0;

local class     = class;
local Scaler    = Scaler;
local _bHasInit = false;
local _oScaler  = null;


local tBank     = {};
local tTypes    = {
    [OBJECT_BUTTON] 		= Button,
    [OBJECT_CHECKBOX] 		= CheckBox,
    [OBJECT_COMBOBOX] 		= ComboBox,
    [OBJECT_FLASH] 			= Flash,
    [OBJECT_GRID] 			= Grid,
    [OBJECT_HOTSPOT] 		= Hotspot,
    [OBJECT_IMAGE] 			= Image,
    [OBJECT_INPUT] 			= Input,
    [OBJECT_LABEL] 			= Label,
    [OBJECT_LISTBOX] 		= ListBox,
    [OBJECT_PARAGRAPH] 		= Paragraph,
    [OBJECT_PDF] 			= PDF,
    [OBJECT_PLUGIN] 		= Plugin,
    [OBJECT_PROGRESS] 		= Progress,
    [OBJECT_QUICKTIME] 		= QuickTime,
    [OBJECT_RADIOBUTTON]	= RadioButton,
    [OBJECT_RICHTEXT] 		= RichText,
    [OBJECT_SLIDESHOW] 		= SlideShow,
    [OBJECT_TREE] 			= Tree,
    [OBJECT_VIDEO] 			= Video,
    [OBJECT_WEB] 			= Web,
    [OBJECT_XBUTTON] 		= xButton,
};

local function InitPagesAndDialogs(this, cdat)
    local tDialogs 	= Application.GetDialogs();
    local tPages 	= Application.GetPages();

    if (tDialogs) then
        local tViewport = _oScaler.getViewport();
        local tCOV      = _oScaler.getCOV();
        local nCOV_XW   = tCOV.xw;
        local nCOV_YH   = tCOV.yh;


        for nIndex, sDialog in pairs(tDialogs) do
            local tProps = Application.GetDialogProperties(sDialog);

            local nNewWidth     = tProps.Width  * nCOV_XW;
            local nNewHeight    = tProps.Height * nCOV_YH;

            --determine and set the dialog's new size
            Application.SetDialogProperties(sDialog,
                {
                    Width   = nNewWidth,
                    Height  = nNewHeight,
                });

            tBank[sDialog] = {
                HasBeenScaled = false,
                Scaler = Scaler(tProps.Width, tProps.Height, nNewWidth, nNewHeight),
                Type = DialogEx,
                Properties = Application.GetDialogProperties(sDialog);
            };
        end

    end

    if (tPages) then

        for nIndex, sPage in pairs(tPages) do
            tBank[sPage] = {
                HasBeenScaled = false,
                Type = Page,
                Properties = Application.GetPageProperties(sPage);
            };
        end

    end
end

ScalerX = class("ScalerX",
{--METAMETHODS

},
{--STATIC PUBLIC
    --AMSScaler = function(stapub) end,
	MarkForRescale = function(sName)
		tBank[sName].HasBeenScaled = false;
	end,
    OnPreload = function(sName)

    	if (_bHasInit and not tBank[sName].HasBeenScaled) then
            local tInfo         = tBank[sName]; --TODO throw error here if the page/dialog doesn't exist
    		local tPageDialog   = tInfo.Type;
            local oScaler       = tPageDialog == Page and _oScaler or tInfo.Scaler;

    		tBank[sName].HasBeenScaled = true;
    		Application.SetRedraw(false);

    		--adjust for original build size and actual viewport size
    		tDelta = 0;

    		--get the page/dialog objects
    		local tObjects = tPageDialog.EnumerateObjects();

    		--enumerate through the objects
    		if (tObjects) then

    			for nIndex, sObject in pairs(tObjects) do
    				--get the object type
                    local tObjectType = tPageDialog.GetObjectType(sObject);
    				local tObject = tTypes[tObjectType];
    				--get the object's size and position
    				local tSize = tObject.GetSize(sObject);
    				local tPos 	= tObject.GetPos(sObject);
    				--scale and transform the object
    				local tDelta = oScaler.adjust({width = tSize.Width, height = tSize.Height, x = tPos.X, y = tPos.Y});
    				tObject.SetSize(sObject, tDelta.width, tDelta.height);
    				tObject.SetPos(sObject, tDelta.x, tDelta.y);

                    --adjust font size as needed
                    if (tObjectType == OBJECT_PARAGRAPH) then
                        local tProps    = Paragraph.GetProperties(sObject);
                        local nFontSize = tProps.FontSize * _nFontCo;
                        --Dialog.Message("", tostring(tProps.FontSize).."\n"..tostring(_nFontCo))
                        Paragraph.SetProperties(sObject, {FontSize = nFontSize});
                    end

    			end

    		end

    		Application.SetRedraw(true);
    	end

    end,


    OnStartup = function(nBuildWidth, nBuildHeight)

		if not (LUAEX_INIT) then
			error("Error loading ScalerX plugin. ScalerX requires LuaEx.\r\nPlease call this method after you've initialized LuaEx.");
		end

        if not (_bHasInit) then
            local bContinue =   rawtype(nBuildWidth)    == "number" and
                                rawtype(nBuildHeight)   == "number" and
                                nBuildWidth > 0 and nBuildHeight > 0;

            if (bContinue) then
                _nBuildWidth    = nBuildWidth;
                _nBuildHeight   = nBuildHeight;

                local hWnd = Application.GetWndHandle();

            	--get the screen size and set the app window size
            	local tDisplay = System.GetDisplayInfo();

                _nDisplayWidth = tDisplay.Width;
                _nDisplayHeight = tDisplay.Height;

            	Window.SetSize(hWnd, _nDisplayWidth, _nDisplayHeight);
            	Window.SetPos(hWnd, 0, 0);

                --set the font coefficient
                _nXHorCo = _nDisplayWidth  /  _nBuildWidth;
                _nYVerCo = _nDisplayHeight /  _nBuildHeight;
                _nFontCo = (_nXHorCo + _nYVerCo) / 3;--TODO this 3 is a magic number and a guess, figure out what number would work in all cases

            	--create the outer/inner rects and calculate the (centered) viewport rect
            	local tOuter = {width = tDisplay.Width, height = tDisplay.Height, x = 0, y = 0};
            	local tInner = {width = nBuildWidth, height = nBuildHeight};
                --print(nBuildWidth, nBuildHeight);
            	local tViewport = math.geometry.fitrect(tOuter, tInner, true);

            	--get the additional x and y offsets (since the build size is different than the viewport size)
            	local nXOffset = math.abs(tViewport.width - nBuildWidth) / 2;
            	local nYOffset = math.abs(tViewport.height - nBuildHeight) / 2;

            	--initialize the scaler system
            	_oScaler = Scaler(tInner.width, tInner.height, tOuter.width, tOuter.height, true);--, nXOffset, nYOffset);

                InitPagesAndDialogs();

                _bHasInit = true;
            end

        end

    end,
},
{--PRIVATE
    ScalerX = function(this, cdat) end
},
{},--PROTECTED
{--PUBLIC

},
nil,   --extending class
true,  --if the class is final
nil    --interface(s) (either nil, or interface(s))
);
