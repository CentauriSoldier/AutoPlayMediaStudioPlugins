--#########################################################################################################
-- Converts certain datatypes into other datatypes ||| Supported Types |||
-- [String <-> Boolean] [Number <-> Boolean] [String <-> Number]
--#########################################################################################################
local CONVERT = function (vInput, sNewType)
local sOldType = type(vInput);

if sNewType == "boolean" then

	if sOldType == "string" then

		if String.Lower(vInput) == "true" then
		return true
		elseif String.Lower(vInput) == "false" then
		return false
		end
		
	elseif sOldType == "number" then
		
		if vInput == 0 then
		return false
		elseif vInput == 1 then
		return true
		end
	
	elseif sOldType == "table" then
	
		if vInput then
		return true
		else
		return false
		end
	
	else
	
	return false	
	end

elseif sNewType == "string"	then
	
	if sOldType == "boolean" then
	
		if vInput == true then
		return "true"
		elseif vInput == false then
		return "false"
		end
	
	elseif sOldType == "number" then
	return ""..vInput..""
	
	else
	
	return ""
	end

elseif sNewType == "number" then
	
	if sOldType == "boolean" then
	
		if vInput == true then
		return 1
		elseif vInput == false then
		return 0
		end
	
	elseif sOldType == "string" then
	
	return tonumber(vInput)				
	
	else
	
	return -1
	end

end
end