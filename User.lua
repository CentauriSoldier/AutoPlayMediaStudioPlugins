--[[*
@authors <p>James Jones</p>
@copyright <p>Mt Si Senior Center</p>
@dependencies
@description <p>A support module that handles a single abstract user object.
				This user object is not intended to be used for handling usernames,
				passwords, etc. Furthermore, it is not intended to be used for authentication.
				It is intended to store info like user display name and security level.</p>
@features 
@email jamesj@mtsiseniorcenter.org
@license Copyright © 2019 All Rights Reserved
@moduleid(required) User
@plannedfeatures
@todo
@usage
@version 1.2
@versionhistory
@website
*]]
User = {};

USER_SEC_EVR = 1;
USER_SEC_VOL = 2;
USER_SEC_STF = 3;
USER_SEC_ADM = 4;

USER_SEC_NAMES = {
	USER_SEC_EVR = "Everyone",
	USER_SEC_VOL = "Volunteer",
	USER_SEC_STF = "Staff",
	USER_SEC_ADM = "Administrator",
	["Everyone"] 		= USER_SEC_EVR,
	["Volunteer"] 	 	= USER_SEC_VOL,
	["Staff"] 			= USER_SEC_STF,
	["Administrator"] 	= USER_SEC_ADM,
};

local tUser = {
	DisplayName = {
		Current = "",
		Default = "",
	},
	SecurityLevel = {
		Current = 1,
		Default = 1,
	},	
	MaxNameLength = 32,
	Username = "",
};

--[[!

!]]
function User.GetMaxNameLength()
	return tUser.MaxNameLength;
end

local function SetUserDefaults()

	tUser.DisplayName.Current = tUser.DisplayName.Default;
	tUser.SecurityLevel.Current = tUser.SecurityLevel.Default;

end


function User.Logout(bUpdateMenu)
	SetUserDefaults();	
end


function User.SetDisplayName(sDisplayName)
	tUser.DisplayName.Current = sDisplayName;
end

function User.SetSecurityLevel(nSecurityLevel)
	tUser.SecurityLevel.Current = nSecurityLevel;
end


function User.Login(sUsername, nSecurityLevel)
	tUser.Username = sUsername;
	tUser.SecurityLevel.Current = nSecurityLevel;	
end


function User.GetDisplayName()
	return tUser.DisplayName.Current;
end


function User.GetUsername()
	return tUser.Username;
end


function User.GetSecurityLevel()
	return tUser.SecurityLevel.Current;

end