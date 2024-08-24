enemies = {}
--damage, health, attack speed, abillities, level
enemies["Gearrat"] = {}
enemies["Gearrat"].id = "Gearrat"
enemies["Gearrat"].eflags = {}
enemies["Gearrat"].timers = {}

enemies["Gearrat"].offsetXbattle = 100
enemies["Gearrat"].offsetYbattle = 120

enemies["Gearrat"].eflags.isIdle = 1
enemies["Gearrat"].eflags.isAttacking = 0

enemies["Gearrat"]["Attacks"] = {"enemyBite"}

enemies["Gearrat"].turnspeed = 8
enemies["Gearrat"].MAXhealth = 45
enemies["Gearrat"].currentHealth = 45
enemies["Gearrat"].adamage = 15
enemies["Gearrat"].level = 1
enemies["Gearrat"].xpbase = 5

--VOID
enemies["Void"] = {}
enemies["Void"].id = "Void"
enemies["Void"].eflags = {}
enemies["Void"].timers = {}

enemies["Void"].offsetXbattle = 100
enemies["Void"].offsetYbattle = 120

enemies["Void"].eflags.isIdle = 1
enemies["Void"].eflags.isAttacking = 0

enemies["Void"]["Attacks"] = {"enemyBite"}

enemies["Void"].turnspeed = 0
enemies["Void"].MAXhealth = 0
enemies["Void"].currentHealth = 0
enemies["Void"].adamage = 0
enemies["Void"].level = 0
enemies["Void"].xpbase = 0

enemyparty = {}
enemyparty[1] = {"Gearrat", "Gearrat", "Gearrat", "Gearrat"}

--do an enemy pool (like, formations and stuff, easy, normal and hard difficult)
--also, program more enemies. This file should be from where the enemy actors inherit the enemy stats and sprites
--to the battle script
