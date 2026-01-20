--TODO localization and comments for sections (and sort sections)
local type 		= type;
local rawtype 	= rawtype;
local clamp     = math.clamp;

function Color.TryFromString(vInput, bForceAlpha)
    local nRet = nil;

    if (type.isstring(vInput)) then
        local sTrimmed = vInput:trim();

        -- HEX: RRGGBB / #RRGGBB / RRGGBBAA / #RRGGBBAA
        local sHex = sTrimmed:sub(1,1) == "#" and sTrimmed:sub(2) or sTrimmed;
        if (sHex:match("^[%x]+$")) then
            local nLen = #sHex;

            if (nLen == 6 or nLen == 8) then
                local nRed   = tonumber(sHex:sub(1,2), 16);
                local nGreen = tonumber(sHex:sub(3,4), 16);
                local nBlue  = tonumber(sHex:sub(5,6), 16);

                if (nLen == 8) then
                    local nAlpha = tonumber(sHex:sub(7,8), 16);
                    nRet = Color.RGBA(nRed, nGreen, nBlue, nAlpha);
                else
                    if (toboolean(bForceAlpha)) then
                        nRet = Color.RGBA(nRed, nGreen, nBlue, 255);
                    else
                        nRet = Color.RGB(nRed, nGreen, nBlue);
                    end
                end
            end
        end

        -- CSV: r,g,b or r,g,b,a (only if hex path didn’t succeed)
        if (nRet == nil) then
            local tValuesRaw = (not sTrimmed:isempty()) and sTrimmed:totable(',') or nil;

            if (tValuesRaw) then
                local tValues = {};
                local bValid  = true;

                for _, vValue in ipairs(tValuesRaw) do
                    local nVal = tonumber(vValue);

                    if not type.isnumber(nVal) then
                        bValid = false;
                        break;
                    end

                    tValues[#tValues + 1] = nVal;
                end

                local nValues = #tValues;

                if (bValid) then
                    if (nValues == 3) then
                        local nRed   = clamp(tValues[1], 0, 255);
                        local nGreen = clamp(tValues[2], 0, 255);
                        local nBlue  = clamp(tValues[3], 0, 255);

                        if (toboolean(bForceAlpha)) then
                            nRet = Color.RGBA(nRed, nGreen, nBlue, 255);
                        else
                            nRet = Color.RGB(nRed, nGreen, nBlue);
                        end

                    elseif (nValues == 4) then
                        nRet = Color.RGBA(
                            clamp(tValues[1], 0, 255),
                            clamp(tValues[2], 0, 255),
                            clamp(tValues[3], 0, 255),
                            clamp(tValues[4], 0, 255)
                        );
                    end
                end
            end
        end
    end

    return nRet;
end


function Application.IsCompiled()
    local sParent = String.Mid(_ExeFolder, String.ReverseFind(_ExeFolder, "\\") + 1, -1);
    local bRet = true;

    if String.Lower(sParent) == "cd_root" then
	    bRet = false;
    end

    return bRet;
end

function INIFile.GetValueBoolean(pFile, sSection, sValue)
    local bRet = false;

    local bFileIsString     = type(pFile) =="string";
    local bSectionIsString  = type(sSection) == "string";
    local bValueIsString    = type(sValue) == "string";

    if (bFileIsString and bSectionIsString and bValueIsString) then
        local sValue = INIFile.GetValue(pFile, sSection, sValue);
        bRet = sValue:lower() == "true" and true or false;
    end

    return bRet;
end

--TODO FIX THIS as I did above
function INIFile.GetValueNumber(pFile, sSection, sValue)
	local nRet = 0;

	if (type(pFile) =="string" and type(sSection) == "string" and type(sValue) == "string") then
		local nValue = tonumber(INIFile.GetValue(pFile, sSection, sValue));
		nRet = nValue ~= nil and nValue or nRet;
	end

	return nRet;
end

function p(...)
	local sArg		= "";
	local tArgs 	= {...} or arg;
	local nArgs 	= #tArgs;
	local sArgs 	= "";
	local sSuffix 	= "\r\n";

	for nIndex, vArg in pairs(tArgs) do

		local sType 		= type(vArg);
		local bIsTable 		= sType == "table";
		local bSerialize	= false;
		local fSerialize 	= nil;

		if (rawtype(vArg) == "table") then
			local fFunc = rawget(vArg, "Serialize");
			local fSerialize = type(fFunc) == "function" and fFunc or nil;

			if not (fSerialize) then
				local fFunc = rawget(vArg, "Serialize");
				fSerialize = type(fFunc) == "function" and fFunc or nil;
			end

		end

		local bSerialize 	= type(fSerialize) == "function";
		local bIncludeSelf 	= (bSerialize and not bIsTable) and vArg or nil;

		if type(nIndex) == "number" then

			if (bSerialize) then
				sArg = fSerialize(bIncludeSelf);

			else

				if (bIsTable) then
					sArg = serialize(vArg);

				else
					sArg = tostring(vArg);
				end

			end

			sArgs = sArgs..nIndex..": "..sArg..((nIndex < nArgs) and "\r\n\r\n" or "");
		end

	end

	Dialog.Message("Debug", sArgs);
end


local fDialogExClose = DialogEx.Close;
local fDialogExShow = DialogEx.Show;
local _vDialogExDefaultRet = fDialogExClose;
local _vDialogExRet;
--TODO look more closely at this! why this ? _vDialogExDefaultRet
function DialogEx.Close(...)
    _vDialogExRet = {...};
    _vDialogExDefaultRet = fDialogExClose();
end

function DialogEx.Show(sName, bUseParentCoords, nX, nY)
    fDialogExShow(sName, bUseParentCoords, nX, nY);
    --return table.unpack(_vDialogExRet or {});
    return table.unpack(_vDialogExRet or {});
end

local function GridEmpty(sInput) return sInput; end

function Grid.GetColumnIDByName(sGrid, sName, bCaseSensitiveRaw)
    local nRet              = nil;
    local bCaseSensitive    = type(bCaseSensitiveRaw) == "boolean" and bCaseSensitiveRaw or false;
    local fCase             = bCaseSensitive and string.lower or GridEmpty;

    for x = 1, Grid.GetColumnCount(sGrid) do
        local nColumn = x - 1;

        if (fCase(Grid.GetCellText(sGrid, 0, nColumn)) == fCase(sName)) then
            nRet = nColumn;
            break;
        end

    end

    return nRet;
end

--TODO check this!!!!
function Grid.GetRow(sGrid, nRow)
    local tRet      = {};
    local nColumns  = Grid.GetColumnCount(sGrid);

    local tByColumnID       = {};
    local tByColumnName     = {};
    local tColumns          = {};
    local tColumnIDsByName  = {};

    if nColumns > 0 then

        for nColumn = 0, Grid.GetColumnCount(sGrid) - 1 do
            local sCellText             = Grid.GetCellText(sGrid, nRow, nColumn);
            local sColumn               = Grid.GetCellText(sGrid, 0, nColumn);
            tByColumnID[nColumn]        = sCellText;
            tByColumnName[sColumn]      = sCellText;
            tColumns[nColumn]           = sColumn;
            tColumnIDsByName[sColumn]   = nColumn;
        end

    end

    local nEntries = #tByColumnID;

    local tRetMeta = {
        --returns the name or index of a column given the index or name
        __call = function(t, v)
            local zV = rawtype(v);

            if (zV == "number") then
                return tColumns[v] or nil;
            elseif (zV == "string") then
                return tColumnIDsByName[v];
            end
        end,
        __index = function(t, k)
            local sRet;
            local zK = type(k);

            if (zK == "number") then
                sRet = tByColumnID[k] or nil;
            elseif (zK == "string") then
                sRet = tByColumnName[k] or nil;
            end

            return sRet;
        end,
        __newindex = function() error("Cannot write to read-only row table for grid \""..sGrid.."\" at row "..nRow..".") end,
        __pairs = function(t)
            local nIndex = 0;
            local nMax   = #tByColumnID;

            return function()
                nIndex = nIndex + 1;

                if (nIndex <= nMax) then
                    return nIndex, tColumns[nIndex], tByColumnID[nIndex];
                end
            end
        end,
        __len = function()
            return nEntries;
        end,
    };
    setmetatable(tRet, tRetMeta);

    return tRet;
end

function Grid.TryNumber(sGrid, nRow, nColumn)
    return tonumber(Grid.GetCellText(sGrid, nRow, nColumn)) or 0;
end

Path = {};

function Path.GetEndFolder(pPath)
    local sRet = "";

    if (rawtype(pPath) == "string" and pPath ~= "") then
        local tParts = String.SplitPath(pPath);

        if (rawtype(tParts) == "table") then
            local sFolder = rawtype(tParts.Folder) == "string" and tParts.Folder or "";
            local sName   = rawtype(tParts.Filename) == "string" and tParts.Filename or "";

            -- If the path ends in a slash, AMS puts the *last folder* in Filename
            if (sName ~= "") then
                sRet = sName;
            elseif (sFolder ~= "") then
                -- Otherwise extract from Folder
                if (sFolder:sub(-1) == "\\" or sFolder:sub(-1) == "/") then
                    sFolder = sFolder:sub(1, -2);
                end;

                local nPos = sFolder:match("^.*()\\") or sFolder:match("^.*()/");

                if (nPos) then
                    sRet = sFolder:sub(nPos + 1);
                else
                    sRet = sFolder;
                end

            end

        end

    end

    return sRet;
end
