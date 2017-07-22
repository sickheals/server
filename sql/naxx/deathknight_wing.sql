

-- Death Knight fear targets hostile, not self. Also not on pull, but a while later. -- https://youtu.be/VrykhhdPfc4?t=4m37s
UPDATE `creature_ai_scripts` SET `event_param1`=10000, `event_param2`=12000, `action1_param2`=1 WHERE `id`=1614601;

-- death knight captain spam casts whirlwind (different spell than was originally) 15ec after pull, instead (could be hp based too) https://youtu.be/VrykhhdPfc4?t=4m51s
UPDATE `creature_ai_scripts` SET `event_type`=0, `event_param1`=15000, `event_param2`=15000, `event_param3`=8500, `event_param4`=8500, `action1_param1`=28333, `action1_param2`=1 WHERE `id`=1614501;

-- Death knight captain increased dmg, but reduced attackspeed
UPDATE `creature_template` SET `mindmg`=3500, `maxdmg`=4250, `baseattacktime`=2500 WHERE `entry`=16145;

-- missing npc death lord (16861): https://youtu.be/VrykhhdPfc4?t=6m9s
-- exists in db, but must be scaled up and faction changed.


-- deathknights offhand is a shield, not a mount like it was
UPDATE `creature_template` SET `equipment_id` = 16146 where `entry` = 16146;
DELETE FROM `creature_equip_template` where entry = 16146;
INSERT INTO `creature_equip_template` (entry, equipentry1, equipentry2, equipentry3) VALUES (16146, 2179, 6176, 0);

	
-- scale of death lord and deathknight cavalier update (cavalier was too big, death lord too small)
UPDATE `creature_template` SET `scale` = 1.8 where `entry` IN (16861, 16861);

-- correct faction of death lord
UPDATE `creature_template` SET `faction_A`=21, `faction_H`=21 WHERE `entry`=16861;

-- Death lord deathcoil hits random excluding top aggro, rather than random including top aggro
UPDATE `creature_ai_scripts` SET `action1_param2`=5 WHERE `id`=1686103;

-- death lord
-- https://youtu.be/VrykhhdPfc4?t=6m9s
-- It also kindof looks like the pack in the video does not patroll, unlike it does in our db.
DELETE FROM `creature` where `guid` = 533000 ;
INSERT INTO `creature` (`guid`,`id`,`map`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`spawnFlags`) 
VALUES (533000,16861,533,0,0,2932.73,-3188.07,273.371,3.13692,25,5,0,113175,12430,0,0,0);

-- death lord and death knight cavalier curse of agony event slightly randomized to more easily stack with group when not spread
UPDATE `creature_ai_scripts` SET `event_param2`=2500, `event_param4`=8500 WHERE `id`=1686101;
UPDATE `creature_ai_scripts` SET `event_param2`=2500, `event_param4`=8500 WHERE `id`=1616301;


-- Dark Touched Warrior periodically wipe aggro
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry`=16156;
DELETE FROM `creature_ai_scripts` where id = 1615601;
INSERT INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1615601, 16156, 0, 0, 0, 1, 5000, 5000, 5000, 5000, 14, -100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Touched Warrior periodically wipe aggro');

-- Death Knight raise dead	
DELETE FROM `creature_ai_scripts` where id = 1614603;
INSERT INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1614603, 16146, 0, 0, 100, 1, 5000, 5000, 10000, 20000, 11, 28353, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight raise dead');

-- Death knight frequency of intimidating shout reduced
UPDATE `creature_ai_scripts` SET `event_param3`=14000, `event_param4`=18000 WHERE `id`=1614601;

-- Creatures that the spell Raise Dead can target
-- todo: no idea which creatures should be "ressable", other than other death knights should not be.
DELETE FROM `spell_script_target` where entry = 28353;
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) 
VALUES
(28353, 2, 16165),
(28353, 2, 16167),
(28353, 2, 16154),
(28353, 2, 16193),
(28353, 2, 16156),
(28353, 2, 16157);	


-- unholy weapons
DELETE FROM creature_equip_template where entry in (16194, 16215, 16216);
INSERT into creature_equip_template (entry, equipentry1, equipentry2, equipentry3) VALUES
(16194, 11342, 0, 0),
(16215, 12959, 0, 0),
(16216, 13222, 13222, 0);
-- unholy weapns equipment id
UPDATE `creature_template` SET `unit_flags`=32768, `equipment_id`=16194, MovementType=1, `AIName`='EventAI',`baseattacktime`=2000, `mindmg`=3230, `maxdmg`=4284 WHERE entry=16194;
UPDATE `creature_template` SET `unit_flags`=32768, `equipment_id`=16215, MovementType=1, `AIName`='EventAI',`baseattacktime`=2000, `mindmg`=2500, `maxdmg`=3200 WHERE entry=16215;
UPDATE `creature_template` SET `unit_flags`=32768, `equipment_id`=16216, MovementType=1, `AIName`='EventAI',`baseattacktime`=1600, `mindmg`=2900, `maxdmg`=3700 WHERE entry=16216;

DELETE FROM `creature` where id in (16194, 16215, 16216);
INSERT INTO `creature` (`guid`,`id`,`map`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`, `spawnFlags`) VALUES 
(127794,16194,533,0,0,2707.62,-3244.26,267.682,1.37881, 3600,20,0,113184,0,0,0,0),
(127795,16194,533,0,0,2681.25,-3215.83,267.611,5.46288, 3600,20,0,113184,0,0,0,0),
(127796,16194,533,0,0,2712.35,-3127.26,267.554,2.65744, 3600,20,0,113184,0,0,1,0),
(127797,16194,533,0,0,2718.03,-3135.9, 267.522,4.42918, 3600,20,0,113184,0,0,1,0),
(127798,16194,533,0,0,2712.7, -3180.11,267.605,1.69297, 3600,20,0,113184,0,0,0,0),
(127799,16194,533,0,0,2724.37,-3219.95,267.605,0.261799,3600,20,0,113184,0,0,0,0),
(127815,16215,533,0,0,2703.69,-3240.64,267.669,1.78024, 3600,20,0,88032, 0,0,0,0),
(127816,16215,533,0,0,2731.01,-3154.15,267.589,2.08039, 3600,20,0,88032, 0,0,1,0),
(127817,16215,533,0,0,2742.73,-3164.88,267.652,5.22196, 3600,20,0,88032, 0,0,1,0),
(127818,16215,533,0,0,2691.04,-3216.55,267.605,0.942478,3600,20,0,88032, 0,0,0,0),
(127819,16215,533,0,0,2667.47,-3173,   267.604,4.13059, 3600,20,0,88032, 0,0,1,0),
(127820,16215,533,0,0,2671.65,-3175.75,267.577,4.13054, 3600,20,0,88032, 0,0,1,0),
(127821,16215,533,0,0,2734.57,-3221.58,267.623,2.00713, 3600,20,0,88032, 0,0,0,0),
(127822,16216,533,0,0,2739.77,-3219.47,267.539,4.46863, 3600,20,0,94320, 0,0,1,0),
(127823,16216,533,0,0,2731.77,-3230.92,267.679,4.46872, 3600,20,0,94320, 0,0,1,0),
(127824,16216,533,0,0,2708.13,-3174.65,267.605,0.418879,3600,20,0,94320, 0,0,0,0);


REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1621501, 16215, 0, 0, 100, 1, 4000, 4000, 15000, 15000, 11, 28450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy staff Arcane Explosion');

REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1621502, 16215, 0, 0, 100, 1, 8000, 8000, 15000, 15000, 11, 29848, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unholy staff polymorph');

REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1621503, 16215, 0, 0, 100, 1, 12000, 12000, 15000, 15000, 11, 29849, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unholy staff frost nova');


REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1619401, 16194, 0, 0, 100, 1, 4000, 4000, 15000, 15000, 11, 29852, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unholy axe whirlwind');
REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1619402, 16194, 0, 0, 100, 1, 6000, 6000, 7000, 8000, 11, 16856, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unholy axe Mortal Strike');


REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1621601, 16216, 0, 0, 100, 1, 4000, 4000, 8000, 8000, 11, 15284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unholy swords trash');
REPLACE INTO `creature_ai_scripts`
(`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`)
VALUES
(1621602, 16216, 0, 0, 100, 1, 2000, 2000, 8000, 8000, 11, 15284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'unholy swords cleave');