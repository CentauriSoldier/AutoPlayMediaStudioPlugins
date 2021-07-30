--[[****==*****->
     TypesMatch
<-*****==******]]
function TypesMatch(vFirstValue, vSecondValue)
local sFirstValueType = type(vFirstValue);
local sSecondValueType = type(vSecondValue);

if sFirstValueType ~= sSecondValueType then
return false
end

if sFirstValueType == "table" then
	
	for vIndex, vItem in pairs(vFirstValue) do
		
		--this can be altered to allow missing indices if desired
		if not vSecondValue[vIndex] then
		return false
		end
		
		local sFirstItemType = type(vItem);
		local sSecondItemType = type(vSecondValue[vIndex]);
		
		if sFirstItemType ~= sSecondItemType then
		return false
		end
		
		if sFirstItemType == "table" then
		
			if not TypesMatch(vItem, vSecondValue[vIndex]) then
			return false
			end
						
		end
			
	end
	
end

return true
end