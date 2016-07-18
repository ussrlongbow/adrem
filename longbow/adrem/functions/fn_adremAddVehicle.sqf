/*****************************************************************************
Function name: RWT_fnc_adremAddVehicle;
Authors: longbow
License: MIT License
https://github.com/ussrlongbow/adrem
Version: 1.0
Dependencies:
	NONE

Changelog:	
	=== 1.0 === 17-Jul-2016
		Initial release

Description:
	Function adds a vehicle to Advanced Respawn Manager

Arguments:
	ARRAY [_VEH,_DELAY,_TYPE,_DIST,_INIT,_POS,_DIR,_COND,_OVERRIDE,_NOTIFY,_TICKETS]
		_VEH - object, vehicle to add
		_DELAY - number, respawn delay in seconds
		_TYPE - number, respawn type, currently ignored
		_DIST - number, deserted distance
		_INIT - code, code to be executed for respawned vehicle
		_POS - array, positionASL of respawned vehicle
		_DIR - array, vectorDirAndUp of respawned vehicle
		_COND - code, additional condition to force vehicle respawn
		_OVERRIDE - boolean, override default respawn conditions and rely only
			on _COND
		_NOTIFY - number, show notification when respawned
			0 - no
			1 - show to all sides
			2 - show to opfor
			3 - show to blufor
			4 - show to independent
			5 - show to civilian
		_TICKETS - number of respawns

Returns:
	BOOLEAN, true on successful add

*****************************************************************************/

private _eval = params [
	["_veh",objNull,[objNull]],
	["_delay",30,[0]],
	["_type",1,[0]],
	["_dist",100,[0]],
	["_init",{},[{}]],
	["_pos",[],[[]],[3]],
	["_dir",-1,[0]],
	["_vupdir",[],[[]],[2]],
	["_cond",{},[{}]],
	["_override",false,[false]],
	["_notify",0,[0]],
	["_tickets",-1,[0]]
];
private "_varname";
if (isNull _veh) exitWith {
	diag_log "Incorrect parameters supplied";
	false
};

_veh setVariable ["rwt_adrem_respdelay",_delay];
_veh setVariable ["rwt_adrem_resptype",_type];
_veh setVariable ["rwt_adrem_leavedist",_dist];
_veh setVariable ["rwt_adrem_init",_init];
_veh setVariable ["rwt_adrem_customcond",_cond];
_veh setVariable ["rwt_adrem_override",_override];
_veh setVariable ["rwt_adrem_notify",_notify];

if (_pos isEqualTo []) then
{
	_pos = getPosASL _veh;
};
_veh setVariable ["rwt_adrem_startpos",_pos];

if (_dir == -1) then
{
	_dir = getDir _veh;
};
_veh setVariable ["rwt_adrem_startdir",_dir];

if (_vupdir isEqualTo []) then
{
	_vupdir = vectorDirAndUp _veh;
};
_veh setVariable ["rwt_adrem_vupdir",_vupdir];

rwt_adrem_managedlist pushBackUnique _veh;

if (isInRemainsCollector _veh) then {removeFromRemainsCollector [_veh]};
true
