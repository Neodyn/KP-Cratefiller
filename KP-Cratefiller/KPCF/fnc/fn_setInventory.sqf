/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Adds the items to the active crate.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Check if the storage will be empty
if (count KPCF_inventory == 0) exitWith {
    clearWeaponCargoGlobal KPCF_activeStorage;
    clearMagazineCargoGlobal KPCF_activeStorage;
    clearItemCargoGlobal KPCF_activeStorage;
    clearBackpackCargoGlobal KPCF_activeStorage;
    [] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
};

// Clear the storage
clearWeaponCargoGlobal KPCF_activeStorage;
clearMagazineCargoGlobal KPCF_activeStorage;
clearItemCargoGlobal KPCF_activeStorage;
clearBackpackCargoGlobal KPCF_activeStorage;

// Count the variable index
private _count = count KPCF_inventory;

private _abort = false;

// Adapt the cargo into KPCF variable
for "_i" from 0 to (_count-1) do {
    if (!(KPCF_activeStorage canAdd [(KPCF_inventory select _i) select 1, (KPCF_inventory select _i) select 2])) exitWith {
        _abort = true;
    };
    KPCF_activeStorage addItemCargoGlobal [(KPCF_inventory select _i) select 1, (KPCF_inventory select _i) select 2];
};

// Check for enough inventory capacity
if (_abort) exitWith {
    [] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
    hint format [localize "STR_KPCF_HINTFULL"];
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

[] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
