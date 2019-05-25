/*
	By Ghostrider [GRG]
	Last Modified 7-27-17

	Handles the case where a unit is hit.

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_unit","_instigator","_group","_wp"];
_unit = _this select 0 select 0;
_instigator = _this select 0 select 3;
	diag_log format["EH_AIHit:: _units = %1 and _instigator = %2 units damage is %3",_unit,_instigator, damage _unit];
#ifdef blck_debugMode
if (blck_debugLevel >= 2) then
{
	diag_log format["_fnc_processAIHit::-->> _this = %1",_this];
	diag_log format["EH_AIHit:: _units = %1 and _instigator = %2 units damage is %3",_unit,_instigator, damage _unit];
};
#endif

if (!(alive _unit)) exitWith {[_unit, _instigator] call blck_fnc_processAIKill};
if (damage _unit > 0.95) exitWith {_unit setDamage 1.2; [_unit, _instigator] call blck_fnc_processAIKill};

if (!(isPlayer _instigator)) exitWith {};
diag_log format["_processAIHit: calling [_unit,_instigator] call blck_fnc_alertGroupUnits with _unit = %1 and _instigator = %2",_unit,_instigator];
[_unit,_instigator,50] call GMS_fnc_alertNearbyGroups;
[_instigator] call blck_fnc_alertNearbyVehicles;
_group = group _unit;
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";

if (_unit getVariable ["hasHealed",false]) exitWith {};
if ((damage _unit) > 0.1 ) then
{
	#ifdef blck_debugMode
	if (blck_debugLevel >= 2) then
	{
		diag_log format["_EH_AIHit::-->> Healing unit %1",_unit];
	};
	_unit setVariable["hasHealed",true,true];
	"SmokeShellRed" createVehicle (position _unit);
	_unit addItem "FAK";
	_unit action ["HealSoldierSelf",  _unit];
	_unit setDamage 0;
	_unit removeItem "FAK";
};

