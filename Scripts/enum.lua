local _type = type;
function type(vObj)
	local sType = _type(vObj);
	
	if (sType == "table") then
	
		local tMeta = getmetatable(vObj);
		
		if (tMeta) then
		
			if (tMeta["__type"]) then
				sType = tMeta["__type"];
			end
			
		end
		
	end

	return sType;
end


Enum = {};
local tEnums = {};

--assumes input is correct
local function EnumTypeExists(sEnumType)
	local bRet = false;
	
	if (_G[sEnumType]) then
		local tMT = getmetatable(_G[sEnumType]);
		
		if (tMT.__type) then
			
			if (tMT.__type == sEnumType) then
				bRet = true;
			end
			
		end
		
	end
	
	return bRet;	
end




---assumes the enum type exists and is an enum
local function CreateEnumIndex(sEnumType, sEnumIndex)
	
	

end

--assumes the enum type does not exist and input is correct
local function CreateEnumType(sEnumType)
	
	local function enum_set_guard(tTable, vKey, vValue)
			
		if _G[sEnumType][vKey] then
			error(tostring(vKey).." has already been defined");
		else
			--local tSave = {};
			
			--for k, v in pairs(getmetatable(_G[sEnumType])) do
				--tSave[k] = v;
			--end
					
			
		end
		
	end
	
	
	local tMT = {
		__index = sEnumType,
		__newindex = enum_set_guard,
		__type = sEnumType,
	};
	
	
	if (_G["ENUM"]) then
		
		if (type(["ENUM"]) ~= "ENUM") then
			
		end
		
	end

	_G["ENUM"][sEnumType] = {};
	
	
	
		
			
	setmetatable(_G[sEnumType], tMT);		
end

function Enum(sEnumType, sEnum)
	
	if (not EnumTypeExists(sEnumType)) then	
		print(sEnumType.." doesn't exist");
		CreateEnumType(sEnumType);
	else
		print(sEnumType.." exists");
	end	
	
end

Enum("DOG", "HEIGHT");
print(type(DOG));
DOG.Vals = 17;
print(DOG.Vals);
DOG = "";