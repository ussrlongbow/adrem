/*****************************************************************************
Function name: RWT_fnc_adremRespawnVehicle;
Authors: longbow
License: MIT License
https://github.com/ussrlongbow/adrem
Version: 1.0
Dependencies:
	NONE

Changelog:	
	=== 1.0 === 18-Jul-2016
		Initial release

Description:
	Function respawns a vehicle

Arguments:
	_VEH - object, vehicle to respawn

Returns:
	OBJECT - respawned vehicle

Example:
	[_VEH] call RWT_fnc_adremRespawnVehicle

*****************************************************************************/
params [["_oldveh",objNull,[objNull]]];
private ["_veh","_vehtype","_varname","_pos","_dir","_vupdir","_init","_cond","_delay","_resptype","_dist"];

if (isNull _oldveh) exitWith {diag_log "Incorrect argument"; objNull};

// read vehicle respawn settings
_vehtype = typeOf _oldveh;
_varname = vehicleVarName _oldveh;
_pos = _oldveh getVariable ["rwt_adrem_startpos",[0,0,0]];
_dir = _oldveh getVariable ["rwt_adrem_startdir",0];
_vupdir = _oldveh getVariable ["rwt_adrem_vupdir",[[0,1,0],[0,0,1]]];
_init = _oldveh getVariable ["rwt_adrem_init",{}];
_cond = _oldveh getVariable ["rwt_adrem_customcond",{}];
_delay = _oldveh getVariable ["rwt_adrem_respdelay",30];
_resptype = _oldveh getVariable ["rwt_adrem_resptype",1];
_dist = _oldveh getVariable ["rwt_adrem_leavedist",100];

// create new vehicle
_veh = createVehicle [_vehtype,[(_pos select 0),(_pos select 1),0.2],[],0,"CAN_COLLIDE"];

// set direction and orientation
_veh setDir _dir;
_veh setVectorDirAndUp _vupdir;

// set and broadcast vehicle varname
_veh setVehicleVarName _varname;
missionNamespace setVariable [_varname,_veh];
publicVariable _varname;

// set repsawn settings for new vehicle
_veh setVariable ["rwt_adrem_startpos",_pos];
_veh setVariable ["rwt_adrem_startdir",_dir];
_veh setVariable ["rwt_adrem_vupdir",_vupdir];
_veh setVariable ["rwt_adrem_init",_init];
_veh setVariable ["rwt_adrem_customcond",_cond];
_veh setVariable ["rwt_adrem_respdelay",_delay];
_veh setVariable ["rwt_adrem_resptype",_resptype];
_veh setVariable ["rwt_adrem_leavedist",_dist];

// execute init code for new vehicle
[_oldveh,_veh] call _init;
_veh
