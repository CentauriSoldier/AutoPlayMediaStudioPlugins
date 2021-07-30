function Serialize(tTable, sTableName, sTab)
sTab = sTab or "";
sTmp = ""
sTmp = sTmp..sTab..sTableName.."={"
local tStart = 0

for key, value in pairs(tTable) do

	if tStart == 1 then
    sTmp = sTmp..",\r\n"
    else
    sTmp = sTmp.."\r\n"
    tStart = 1
    end
    
    local sKey = (type(key) == "string") and string.format("[%q]",key) or string.format("[%d]",key);
    if(type(value) == "table") then
    sTmp = sTmp..Serialize(value, sKey, sTab.."\t");
    else
    local sValue = (type(value) == "string") and string.format("%q",value) or tostring(value);
    sTmp = sTmp..sTab.."\t"..sKey.." = "..sValue
    end
end

sTmp = sTmp.."\r\n"..sTab.."}"

return sTmp
end