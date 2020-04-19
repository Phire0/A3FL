["A3PL_DMV_Open",
{
	disableSerialization;
	private ["_display","_control","_nearPlayers"];
	createDialog "Dialog_DMV";
	_display = findDisplay 21;
	_control = _display displayCtrl 1500;

	//fill player list
	_nearPlayers = [];
	{
		if ((player distance _x) < 10 && (getPlayerUID _x) != (getPlayerUID player)) then {_nearPlayers pushback _x};
	} foreach allPlayers;
	{
		_index = _control lbAdd (format ["%1",(_x getVariable ["name",(name _x)])]);
		_control lbSetData [_index,(getPlayerUID _x)];
	} foreach _nearPlayers;

	//lb player list changed eh
	_control ctrlAddEventHandler ["LBSelChanged",{_this call A3PL_DMV_LBChanged;}];

	//Button eventhandler
	_control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["ButtonDown",{[true] call A3PL_DMV_Add;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddEventHandler ["ButtonDown",{[false] call A3PL_DMV_Add;}];

	//licenses that can be added
	_control = _display displayCtrl 2100;
	_pJob = player getVariable ["job","unemployed"];
	{
		private["_id","_name","_type","_canIssue"];
		_id = _x select 0;
		_name = _x select 1;
		_type = _x select 2;
		_canIssue = _x select 3;
		if(_pJob IN _canIssue) then {
			if(_type) then {
				_index = _control lbAdd format["%1 (Company)",_name];
				_control lbSetData [_index,_id];
				_control lbSetValue [_index, parseNumber _type];
			} else {
				_index = _control lbAdd format["%1 (Individual)",_name];
				_control lbSetData [_index,_id];
				_control lbSetValue [_index, parseNumber _type];
			};
		};
	} foreach Config_Licenses;
}] call Server_Setup_Compile;

["A3PL_DMV_LBChanged",
{
	private ["_display","_control","_index"];
	_display = findDisplay 21;
	_control = param [0,ctrlNull];
	_index = param [1,-1];
	_player = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (_index < 0) exitwith {};
	if (isNull _player) exitwith {};

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_control lbAdd format ["%1",([_x,"name"] call A3PL_Config_GetLicense)];
	} foreach (_player getVariable ["licenses",[]]);
}] call Server_Setup_Compile;

//[player,'fml',true] remoteExec ["Server_DMV_Add",2];
["A3PL_DMV_Add",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_add","_display","_control","_target","_license","_licenses","_unable","_index"];
	_add = param [0,true];
	_display = findDisplay 21;
	_control = _display displayCtrl 1500;


	_index = lbCurSel _control;
	if (_index < 0) exitwith {[localize"STR_DMV_SELECTIONPLAYER","red"] call A3PL_Player_Notification;};

	_target = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (isNull _target) exitwith {[localize"STR_DMV_LICENSENOTFOUND","red"] call A3PL_Player_Notification;};

	_control = _display displayCtrl 2100;
	_isCompany = (_control lbValue (lbCurSel _control)) IsEqualTo 1;
	_inCompany = [getPlayerUID _target] call A3PL_Config_InCompany;
	if(_isCompany && (!_inCompany)) exitWith {[localize"STR_DMV_LICNOTCOMP","red"] call A3PL_Player_Notification;};	
	
	if (lbCurSel _control < 0) exitwith {[localize"STR_DMV_SELECTIONLICENSE","red"] call A3PL_Player_Notification;};
	_license = _control lbData (lbCurSel _control);

	_unable = false;
	if(!_isCompany) then {
		_licenses = _target getVariable ["licenses",[]];
		if (_add) then {
			if (_license in _licenses) then {_unable = true;};
		} else {
			if (!(_license in _licenses)) then {_unable = true;};
		};
		if (_unable) exitwith {[localize"STR_DMV_ERRORLICENSEALREADYEXIST","red"] call A3PL_Player_Notification;};
		[_target,_license,_add] remoteExec ["Server_DMV_Add",2];
		if (_add) then {
			[format [localize"STR_DMV_GIVELICENSE",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		} else {
			[format [localize"STR_DMV_REVOKELICENSE",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		};
	} else {
		_cid = [getPlayerUID _target] call A3PL_Config_GetCompanyID;
		[_cid,_license,_add] remoteExec ["Server_Company_SetLicenses",2];
		if (_add) then {
			[format [localize"STR_DMV_GIVELICENSECOMP",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		} else {
			[format [localize"STR_DMV_REVOKELICENSECOMP",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],"green"] call A3PL_Player_Notification;
		};
	};
	[player,14] call A3PL_Level_AddXP;
}] call Server_Setup_Compile;

["A3PL_DMV_Check", {
	private _license = param [0,"driver"];
	private _player = param [1,player];
	private _plicenses = _player getVariable ["licenses",[]];
	if (_license IN _plicenses) then {true;} else {false;};
}] call Server_Setup_Compile;

["A3PL_DMV_Speed", {
	private _vehicle = vehicle player;
	private _actualSpeed = [(speed _vehicle)*0.621371, 0] call BIS_fnc_cutDecimals;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	[format [localize"STR_DMV_CURRENTSPEED",_actualSpeed],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_DMV_Truck", {
	[localize"A3PL_P362_TowTruck",[2757.38,5465.27,0],"DMV",1800] spawn A3PL_Lib_JobVehicle_Assign;
	["STR_DMV_TRUCKSPAWN","green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;