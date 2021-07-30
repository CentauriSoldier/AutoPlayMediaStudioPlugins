--put the following code in your globals
OnKey = {};
_ONKEY_SCRIPTS = {};

--call this function in the On Key event of yor project, page or object (leave e_Key as the argument))
function OnKey.Check(e_Key)
    
for nKey, sScript in pairs(_ONKEY_SCRIPTS) do
    
    if e_Key == nKey then
    loadstring(sScript)();
    break;
    end

end

end

--use this function to assign code to the specified key
function OnKey.SetKeyScript(nKey, sScript)
_ONKEY_SCRIPTS[nKey] = sScript;
end 