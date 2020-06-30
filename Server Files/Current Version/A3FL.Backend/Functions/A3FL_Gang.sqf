/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["A3PL_Gang_SetData",
{
	A3PL_Gang_Data = (_this select 0);
	call A3PL_Gang_Init;
}] call Server_Setup_Compile;

["A3PL_Gang_Init",
{
	private["_group"];
	if (count A3PL_Gang_Data isEqualTo 0) exitWith {};
	{
		_groupData = _x getVariable ["gang_data",nil];
		if (!isNil "_groupData") then {
			_groupID = _x getVariable ["gang_id",nil];
			if (isNil "_groupID") exitWith {};
			if ((A3PL_Gang_Data select 0) isEqualTo _groupID) exitWith {
				_group = _x;
			};
		};
	} forEach allGroups;

	if (!isNil "_group") then {
		[player] joinSilent _group;
		if ((A3PL_Gang_Data select 1) isEqualTo getPlayerUID player) then {
			_group selectLeader player;
		};
	} else {
		_group = group player;
		_group setVariable ["gang_data",A3PL_Gang_Data,true];
	};
}] call Server_Setup_Compile;

["A3PL_Gang_Create",
{
	private _groupName = param [0,""];
	[player, _groupName] remoteExec ["Server_Gang_Create",2];
}] call Server_Setup_Compile;

["A3PL_Gang_Invite",
{
	private _invited = param [0,""];
	if(_invited isEqualTo "") exitWith {["Error during the invite, please try again.","red"] call A3PL_Player_Notification;};

	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
 private _members =  parseSimpleArray (_gang select 3);
	private _maxMembers = _gang select 5;

	if((count _members) > _maxMembers) exitWith {[format [localize"STR_NewGang_4",_maxMembers],"red"] call A3PL_Player_Notification;};

	private _target = [_invited] call A3PL_Lib_UIDToObject;
	if(isNull _target) exitWith {["Cannot find the target, please try again.","red"] call A3PL_Player_Notification;};
	private _hasGang = (group _target) getVariable["gang_data",nil];
	if(isNil '_hasGang') then {
		[_group, player] remoteExec ["A3PL_Gang_InviteReceived",_target];
		[localize"STR_NewGang_25","green"] call A3PL_Player_Notification;
	} else {
		[localize"STR_NewGang_1","red"] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Gang_InviteReceived",
{
	private _group = param [0,grpNull];
	private _sender = param [1,objNull];
	private _gang = _group getVariable ["gang_data",nil];

	if(isNil '_gang') exitWith {};
	private _groupName = _gang select 2;
	private _action = [format["You have been invited to join the group %1. <br/> Would you like to join it?",_groupName],"Gang Invitation","Yes","No"] call BIS_fnc_guiMessage;
	if (!isNil "_action" && {!_action}) exitWith {[format[localize "STR_NewGang_2",player getVariable["name",""]], "red"] remoteExec ["A3PL_Player_Notification",_sender];};

	[player] joinSilent _group;
	[getPlayerUID player, _group] call A3PL_Gang_AddMember;
	[format[localize"STR_NewGang_3",player getVariable["name",""]], "green"] remoteExec ["A3PL_Player_Notification",_sender];
}] call Server_Setup_Compile;

["A3PL_Gang_Created",
{
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _groupName = _gang select 2;
	[format [localize"STR_NewGang_24",_groupName],"green"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_AddMember",
{
	private _addUID = param [0,""];
	private _group = param [1,grpNull];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _members = _gang select 3;
	_members pushBack(_addUID);
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];
}] call Server_Setup_Compile;

["A3PL_Gang_RemoveMember",
{
	private _removeUID = param [0,""];
	private _kicked = param [1,false];
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	_members = _gang select 3;
	_members = _members - [_removeUID];
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];
	if(_kicked) then {
		private _target = [_removeUID] call A3PL_Lib_UIDToObject;
		if(isNull _target) exitWith {["Cannot find the target, please try again.","red"] call A3PL_Player_Notification;};
		[] remoteExec ["A3PL_Gang_Kicked",_target];
	};
}] call Server_Setup_Compile;

["A3PL_Gang_Kicked",
{
	A3PL_Gang_Data = objNull;
    [player] joinSilent (createGroup civilian);
    [format [localize"STR_NewGang_5"],"red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_Leave",
{
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	if(((getPlayerUID player) isEqualTo (_gang select 1))) exitWith {[format [localize"STR_NewGang_6"],"red"] call A3PL_Player_Notification;};

	[getPlayerUID player] call A3PL_Gang_RemoveMember;
	[player] joinSilent (createGroup civilian);
	A3PL_Gang_Data = nil;

	[localize"STR_NewGang_7","green"] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Gang_Delete",
{
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	if(((getPlayerUID player) != (_gang select 1))) exitWith {[format [localize"STR_NewGang_8"],"red"] call A3PL_Player_Notification;};
	[_group,player] remoteExec ["Server_Gang_DeleteGang",2];
}] call Server_Setup_Compile;

["A3PL_Gang_SetLead",
{
	private _newUID = param [0,""];
	private _group = group player;
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};

	if((getPlayerUID player) != (_gang select 1)) exitWith {[format [localize"STR_NewGang_13"],"red"] call A3PL_Player_Notification;};
	if((getPlayerUID player) isEqualTo _newUID) exitWith {[format [localize"STR_NewGang_14"],"red"] call A3PL_Player_Notification;};

	_gang set[1,_newUID];
	_group setVariable["gang_data",_gang,true];

	[_group] remoteExec ["Server_Gang_SetLead",2];
	[format [localize"STR_NewGang_15"],"red"] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Gang_AddBank",
{
	private _group = param [0,grpNull];
	private _amount = param [1,0];
	private _gang = _group getVariable ["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _currentBank = _gang select 4;
	_gang set[4,_currentBank + (_amount)];
	_group setVariable["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveBank",2];
}] call Server_Setup_Compile;

["A3PL_Gang_Capture",
{
	private _obj = param [0,objNull];
	private _win = 10000;
	private _group = group player;

	if((player getVariable ["job","unemployed"]) IN ["fifr","uscg","fisd","doj","dmv","usms"]) exitWith {["You cannot capture a gang hideout while working for a faction!","red"] call A3PL_Player_Notification;};
	if((currentWeapon player) isEqualTo "") exitwith {["You do not brandish any weapon","red"] call A3PL_Player_Notification;};
	if((currentWeapon player) IN ["A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {[localize"STR_NewGang_23","red"] call A3PL_Player_Notification;};
	if(_obj getVariable ["CaptureInProgress",false]) then {["Someone is already capturing this gang hideout!","red"] call A3PL_Player_Notification;};

	_capturedTime = _obj getVariable["CapturedTime",serverTime-1800];
	if(_capturedTime > (serverTime-1800)) exitWith {[localize"STR_NewGang_26","red"] call A3PL_Player_Notification;};

	_gang = _group getVariable["gang_data",nil];
	_gangName = _gang select 2;
	if(isNil '_gang') exitWith {[localize"STR_NewGang_16","red"] call A3PL_Player_Notification;};
	_gangID = _gang select 0;
	if((_obj getVariable["captured",-1]) isEqualTo _gangID) exitWith {[localize"STR_NewGang_17","red"] call A3PL_Player_Notification;};

	_obj setVariable ["CaptureInProgress",true,true];

	[getPos _obj,format["Gang Activity - %1",_gangName],"ColorBlack","mil_dot",120] remoteExec ["A3PL_Lib_CreateMarker",-2];
	[format["%1 has started capturing a gang hideout!",_gangName], "yellow"] remoteExec ["A3PL_Player_Notification",-2];

	if (Player_ActionDoing) exitwith {[localize"STR_NewGang_20","red"] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Capture...",120] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	_animTime = diag_tickTime;
	while {Player_ActionDoing} do {
		if(_animTime >= diag_tickTime-5) then {
			player playMoveNow 'AinvPknlMstpSnonWnonDnon_medic_1';
			_animTime = diag_tickTime;
		};
		if (Player_ActionInterrupted) exitWith {_success = false;};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewGang_21","red"] call A3PL_Player_Notification; _obj setVariable ["CaptureInProgress",false,true];};

	_obj setVariable["captured",_gangID,true];
	_obj setVariable["capturedName",_gangName,true];
	_obj setVariable["CapturedTime",serverTime,true];
	_obj setVariable ["CaptureInProgress",false,true];

	[format[localize "STR_GANG_CAPTURED",_gangName], "yellow"] remoteExec ["A3PL_Player_Notification",-2];

	[getPos _obj,format["Gang Hideout Captured - %1",_gangName],"ColorBlack","mil_dot",120] remoteExec ["A3PL_Lib_CreateMarker",-2];

	[localize"STR_NewGang_22","green"] call A3PL_Player_Notification;
	[_group,_win] call A3PL_Gang_AddBank;
}] call Server_Setup_Compile;

["A3PL_Gang_CapturedPaycheck",
{
	private _objects = [hideout_obj_1,hideout_obj_2,hideout_obj_3,hideout_obj_4,hideout_obj_5,hideout_obj_6];
	private _win = 0;
	private _group = group player;
	private _gang = _group getVariable["gang_data",nil];
	if(isNil '_gang') exitWith {};
	private _gangID = _gang select 0;

	{
		if((_x getVariable["captured",-1]) isEqualTo _gangID) then {_win = _win + 1000;};
	} forEach _objects;
	if(_win isEqualTo 0) exitWith {};

	[format[localize"STR_NewGang_27",_win],"green"] call A3PL_Player_Notification;
	[_group,_win] call A3PL_Gang_AddBank;
}] call Server_Setup_Compile;

["A3PL_Gang_GangTax",{

	private _shop = param [0,objNull];
	private _gangHideout = objNull;

	if(_shop IN [npc_fuel_1,npc_fuel_2,NPC_general_1,npc_supermarket_1,Robbable_Shop_1,npc_perkfurniture,npc_perkfurniture_1,npc_perkfurniture_2,npc_roadworker]) then {
		_gangHideout = hideout_obj_1;
	};
	if(_shop IN [npc_roadworker_3,npc_fuel_9,NPC_general_3,Robbable_Shop_2,npc_supermarket_2,npc_furniture_5,npc_furniture_6,npc_furniture_7,npc_fuel_8]) then {
		_gangHideout = hideout_obj_2;
	};
	if(_shop IN [Robbable_Shop_3,npc_roadworker_1,npc_fuel_6,npc_hunting,npc_illegal_eq,NPC_Big_Weapon_Dealer,npc_weaponfactory_1]) then {
		_gangHideout = hideout_obj_3;
	};
	if(_shop IN [npc_captureship,npc_blackmarket]) then {
		_gangHideout = hideout_obj_4;
	};
	if(_shop IN [npc_fuel_10,Low_End_Car_Shop,npc_shopguns]) then {
		_gangHideout = hideout_obj_5;
	};
	if(_shop IN [npc_perkfurniture_5,npc_perkfurniture_4,npc_perkfurniture_3,Robbable_Shop_5,NPC_general_4,npc_big_dicks_sports,npc_fuel_11,chemical_dealer,npc_fuel_12,NPC_Buckeye]) then {
		_gangHideout = hideout_obj_6;
	};


	if(_gangHideout isEqualTo objNull) exitWith {};
	_gangID = _gangHideout getVariable ["captured",0];

	if(_gangID isEqualTo 0) exitWith {};

	_gangName = _gangHideout getVariable ["capturedName",""];
	_gangData = [_gangID,_gangName];


	_gangData
}] call Server_Setup_Compile;

["A3PL_Gang_Secure",
{
	private _obj = param [0,objNull];

	if((currentWeapon player) isEqualTo "") exitwith {["You do not brandish any weapon","red"] call A3PL_Player_Notification;};
	if((currentWeapon player) IN ["A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {[localize"STR_NewGang_23","red"] call A3PL_Player_Notification;};
	_nilCheck = _obj getVariable ["captured",nil];
	if(isNil "_nilCheck") exitWith{["This gang hideout is currently not captured!","red"] call A3PL_Player_Notification;};
	if(_obj getVariable ["CaptureInProgress",false]) then {["Someone is already capturing this gang hideout!","red"] call A3PL_Player_Notification;};


	if (Player_ActionDoing) exitwith {[localize"STR_NewGang_20","red"] call A3PL_Player_Notification;};

	_gangName = _obj getVariable["capturedName",""];
	_faction = player getVariable["faction",""];
	[getPos _obj,format["%1 Gang Hideout - %1",(toUpper _faction),_gangName],"ColorBlack","mil_dot",120] remoteExec ["A3PL_Lib_CreateMarker",-2];
	[format["%1 has started capturing a gang hideout from %2!",(toUpper _faction),_gangName], "yellow"] remoteExec ["A3PL_Player_Notification",-2];
	Player_ActionCompleted = false;
	_obj setVariable ["CaptureInProgress",true,true];
	["Securing Gang Hideout...",120] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	_success = true;
	_animTime = diag_tickTime;
	while {Player_ActionDoing} do {
		if (Player_ActionInterrupted) exitWith {_success = false;};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {[localize"STR_NewGang_21","red"] call A3PL_Player_Notification;_obj setVariable ["CaptureInProgress",false,true];};


	_obj setVariable["captured",nil,true];
	_obj setVariable["capturedName",nil,true];
	_obj setVariable["CapturedTime",nil,true];
	_obj setVariable ["CaptureInProgress",false,true];

	[format["%1 has secured a gang hideout from %2",(toUpper _faction),_gangName], "blue"] remoteExec ["A3PL_Player_Notification",-2];
	[_faction] remoteExec ["Server_Gang_RewardFactions",2];

}] call Server_Setup_Compile;
