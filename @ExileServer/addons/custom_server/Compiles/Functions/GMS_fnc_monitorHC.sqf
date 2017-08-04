/*
	Check if an HC is connected and if so transfer some AI to it.
	By Ghostrider-DbD-
	Last modified 11-8-16
/*
	By Ghostrider-DbD-
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private _hc = missionNamespace getVariable["HC1","null"];
diag_log format["monitorHC::->> _hc = %1",_hc];
if !( (typeName _hc isEqualTo "OBJECT" || _hc isEqualTo "null") ) exitWith {};

if (typeOf _hc isEqualTo "HeadlessClient_F") then // a valid headless client is connected
{
	private _hcOwner = owner _hc;
	private _xfered = 0;
	{
		if (!(isPlayer _x) && (groupOwner _x != _hcOwner) ) then {
			_x setGroupOwner (_hcOwner); 
			_xfered = +1;
			diag_log format["monitorHC::-->> group %1 transfered to HC1",_x];
		};
		if (_xfered isEqualTo 6) exitWith {};
	}forEach allGroups;
};
