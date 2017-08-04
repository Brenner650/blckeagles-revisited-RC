
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 11-11-16
	Fill a crate with items
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	private["_a1","_item","_diff"];
	params["_crate","_boxLoot","_itemCnts"];
	
	_itemCnts params["_wepCnt","_magCnt","_opticsCnt","_materialsCnt","_itemCnt","_bkcPckCnt"];
	
	if (_wepCnt > 0) then
	{
		_a1 = _boxLoot select 0; // choose the subarray of weapons and corresponding magazines
		// Add some randomly selected weapons and corresponding magazines
		for "_i" from 1 to _wepCnt do {
			_item = selectRandom _a1;
			if (typeName _item isEqualTo "ARRAY") then  //  Check whether weapon name is part of an array that might also specify an ammo to use
			{ 
				_crate addWeaponCargoGlobal [_item select 0,1];  // if yes then assume the first element in the array is the weapon name
				if (count _item >1) then {  // if the array has more than one element assume the second is the ammo to use.
					_crate addMagazineCargoGlobal [_item select 1, 1 + round(random(3))];
				} else { // if the array has only one element then lets load random ammo for it
					_crate addMagazineCargoGlobal [selectRandom (getArray (configFile >> "CfgWeapons" >> (_item select 0) >> "magazines")), 1 + round(random(3))];
				};
			} else {
				if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
				{
					_crate addWeaponCargoGlobal [_item, 1];
					_crate addMagazineCargoGlobal [selectRandom (getArray (configFile >> "CfgWeapons" >> _item >> "magazines")), 1 + round(random(3))];
				};
			};
		};
	};
	if (_magCnt > 0) then
	{	
	// Add Magazines, grenades, and 40mm GL shells
		_a1 = _boxLoot select 1;
		for "_i" from 1 to _magCnt do {
			_item = selectRandom _a1;
			_diff = (_item select 2) - (_item select 1);  // Take difference between max and min number of items to load and randomize based on this value
			_crate addMagazineCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];
		};
	};
	if (_opticsCnt > 0) then
	{
		// Add Optics
		_a1 = _boxLoot select 2;
		for "_i" from 1 to _opticsCnt do {
			_item = selectRandom _a1;
			_diff = (_item select 2) - (_item select 1); 
			_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];		
		};
	};
	if (_materialsCnt > 0) then
	{
		// Add materials (cindar, mortar, electrical parts etc)
		_a1 = _boxLoot select 3;
		for "_i" from 1 to _materialsCnt do {
			_item = selectRandom _a1;
			_diff = (_item select 2) - (_item select 1); 
			_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];		
		};
	};
	if (_itemCnt > 0) then
	{
		// Add Items (first aid kits, multitool bits, vehicle repair kits, food and drinks)
		_a1 = _boxLoot select 4;
		for "_i" from 1 to _itemCnt do {
			_item = selectRandom _a1;
			_diff = (_item select 2) - (_item select 1); 
			_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];		
		};
	};	
	if (_bkcPckCnt > 0) then
	{
		_a1 = _boxLoot select 5;
		for "_i" from 1 to _bkcPckCnt do {
			_item = selectRandom _a1;
			_diff = (_item select 2) - (_item select 1); 
			_crate addbackpackcargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];	
		};
	};
