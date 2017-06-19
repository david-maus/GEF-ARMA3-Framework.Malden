////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// 							GEF MissionCreate Framework 1.0 								 ///////////
///////////                                       David Maus		                                   	 ///////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// initPlayerLocal.sqf - Wird beim Start der Mission und beim nachjoinen von Client ausgeführt






//#################################################################################################################
//------- Mission -------

_dummyBigLoadscreen         = 0;			// Aktiviert einen großen Dummy Loadscreen nach dem joinen

//#################################################################################################################
//#################################################################################################################
//------- Gameplay -------

_respawnOnGroup             = 1;            // Respawn auf Gruppenmitgliedern

_restoreLoadOut 			= 1;			// Stellt das Gear vor dem Tot nachdem REspawn wieder her

_fuelSystem                 = 1;			// Aktiviert das Fuel System, mehr Verbrauch in der Mission

//#################################################################################################################













////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// -------------------------------------- Scriptausführung
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Dummy Big Load Screen
if (_dummyBigLoadscreen == 1) then
{
    [] spawn {
        disableSerialization;
        waitUntil {!isNull (findDisplay 46)};
        _display = findDisplay 46;
        _control = _display ctrlCreate ["RscPicture", 22505];
        _control ctrlSetPosition [safezoneX, safezoneY, safezoneW, safezoneH];
        _control ctrlCommit 0;
        _control ctrlSetText "media\images\loadScreenBig.jpg";
        sleep 8;
        ctrlDelete _control;
    };
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Restore Loadout nach Respawn
if (_restoreLoadOut == 1) then
{
    // Save loadout
    player addEventHandler ["Killed", {
            [player, [missionNamespace, getPlayerUID player]] call BIS_fnc_saveInventory;
        }
    ];


    // Load saved loadout on respawn
    player addEventHandler ["Respawn", {
            [player, [missionNamespace, getPlayerUID player]] call BIS_fnc_loadInventory;

        }
    ];
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Fuel Script - Mehr Verbrauch
if (_fuelSystem == 1) then
{
    player addEventHandler ["GetInMan", {[_this select 2] execVM "scripts\other\kp_fuel_consumption.sqf";}];
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Respawn auf Gruppenmitglieder
if (_respawnOnGroup == 1) then
{
    // Save loadout
    player addEventHandler ["Killed", {
            {
                [player, _x, name _x] call BIS_fnc_addRespawnPosition;
            }forEach units group player;
        }
    ];

};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// -------------------------------------- Hier unten anderen Code und andere Scripte ausführen
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
