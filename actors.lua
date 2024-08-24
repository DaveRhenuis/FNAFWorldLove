--Here is all the actors from battle

--PUT EVERYTHING IMPORTANT FROM EVERY CHARACTER HERE!!!!

--Fredbear
actors = {}
actors["Fredbear"] = {}
actors["Fredbear"].id = "Fredbear"
actors["Fredbear"].aflags = {}
actors["Fredbear"].timers = {}
actors["Fredbear"].offsetX = 125
actors["Fredbear"].offsetY = 170
actors["Fredbear"].offsetXbattle = 130
actors["Fredbear"].offsetYbattle = 190

actors["Fredbear"].attackTimer = 0.68
actors["Fredbear"].glitchTimer = 0.30
actors["Fredbear"]["Attacks"] = {"Glitch", "Mimic Ball", "Regen Song", "Mega Bite"}

actors["Fredbear"].turnspeed = 11
actors["Fredbear"].MAXhealth = 80
actors["Fredbear"].currentHealth = 80
actors["Fredbear"].adamage = 20
actors["Fredbear"].level = 1
actors["Fredbear"].experience = 0

actors["Fredbear"].expToLevelUp = 50
actors["Fredbear"].healthPerLevel = 5
actors["Fredbear"].damagePerLevel = 2
actors["Fredbear"].turnspeedPerLevel = 0.3

actors["Fredbear"].isDead = 0
--fredbear health/level = 5
--change health to MAXhealth, and currentHealth!!!!

--Freddy
actors["Freddy"] = {}
actors["Freddy"].id = "Freddy"
actors["Freddy"].aflags = {}
actors["Freddy"].timers = {}
actors["Freddy"].offsetX = 125
actors["Freddy"].offsetY = 125
actors["Freddy"].offsetXbattle = 130
actors["Freddy"].offsetYbattle = 150

actors["Freddy"].attackTimer = 0.84
actors["Freddy"]["Attacks"] = {"Unscrew", "Birthday", "Pizza Wheel", "Mic Toss"}

actors["Freddy"].turnspeed = 10
actors["Freddy"].MAXhealth = 100
actors["Freddy"].currentHealth = 100
actors["Freddy"].adamage = 15
actors["Freddy"].level = 1
actors["Freddy"].experience = 0

actors["Freddy"].expToLevelUp = 50
actors["Freddy"].healthPerLevel = 7
actors["Freddy"].damagePerLevel = 1.5
actors["Freddy"].turnspeedPerLevel = 0.3

actors["Freddy"].isDead = 0
--freddy health/level 7
--change health to MAXhealth, and currentHealth!!!!

--Bonnie
actors["Bonnie"] = {}
actors["Bonnie"].id = "Bonnie"
actors["Bonnie"].aflags = {}
actors["Bonnie"].timers = {}
actors["Bonnie"].offsetX = 125
actors["Bonnie"].offsetY = 125
actors["Bonnie"].offsetXbattle = 130
actors["Bonnie"].offsetYbattle = 150

actors["Bonnie"].attackTimer = 0.64
actors["Bonnie"]["Attacks"] = {"Solo", "Happy Jam", "Bash Jam", "Bite"}

actors["Bonnie"].turnspeed = 13
actors["Bonnie"].MAXhealth = 80
actors["Bonnie"].currentHealth = 80
actors["Bonnie"].adamage = 20
actors["Bonnie"].level = 1
actors["Bonnie"].experience = 0

actors["Bonnie"].expToLevelUp = 50
actors["Bonnie"].healthPerLevel = 5
actors["Bonnie"].damagePerLevel = 2
actors["Bonnie"].turnspeedPerLevel = 0.3

actors["Bonnie"].isDead = 0
--bonnie health/level 5
--change health to MAXhealth, and currentHealth!!!!

--Chica
actors["Chica"] = {}
actors["Chica"].id = "Chica"
actors["Chica"].aflags = {}
actors["Chica"].timers = {}
actors["Chica"].offsetX = 125
actors["Chica"].offsetY = 125
actors["Chica"].offsetXbattle = 130
actors["Chica"].offsetYbattle = 150

actors["Chica"].attackTimer = 0.76
actors["Chica"]["Attacks"] = {"Regen Song", "Party Favors", "Cupcake", "Bite"}

actors["Chica"].turnspeed = 12
actors["Chica"].MAXhealth = 50
actors["Chica"].currentHealth = 50
actors["Chica"].adamage = 20
actors["Chica"].level = 1
actors["Chica"].experience = 0

actors["Chica"].expToLevelUp = 50
actors["Chica"].healthPerLevel = 4
actors["Chica"].damagePerLevel = 1.5
actors["Chica"].turnspeedPerLevel = 0.3

actors["Chica"].isDead = 0
--chica health/level 4
--change health to MAXhealth, and currentHealth!!!!

--Foxy
actors["Foxy"] = {}
actors["Foxy"].id = "Foxy"
actors["Foxy"].aflags = {}
actors["Foxy"].timers = {}
actors["Foxy"].offsetX = 125
actors["Foxy"].offsetY = 125
actors["Foxy"].offsetXbattle = 130
actors["Foxy"].offsetYbattle = 150

actors["Foxy"].attackTimer = 0.76
actors["Foxy"]["Attacks"] = {"Birthday", "Hot Cheese", "Jumpscare", "Hook"}

actors["Foxy"].turnspeed = 14
actors["Foxy"].MAXhealth = 60
actors["Foxy"].currentHealth = 60
actors["Foxy"].adamage = 20
actors["Foxy"].level = 1
actors["Foxy"].experience = 0

actors["Foxy"].expToLevelUp = 50
actors["Foxy"].healthPerLevel = 4
actors["Foxy"].damagePerLevel = 2
actors["Foxy"].turnspeedPerLevel = 0.3

actors["Foxy"].isDead = 0
--foxy health/level 4
--change health to MAXhealth, and currentHealth!!!!

actors["Void"] = {}
actors["Void"].id = "Void"
actors["Void"].aflags = {}
actors["Void"].timers = {}
actors["Void"].offsetX = 125
actors["Void"].offsetY = 125
actors["Void"].offsetXbattle = 130
actors["Void"].offsetYbattle = 150

actors["Void"].attackTimer = 0
actors["Void"]["Attacks"] = {"Void", "Void", "Void", "Void"}

actors["Void"].turnspeed = 0
actors["Void"].MAXhealth = 0
actors["Void"].currentHealth = 0
actors["Void"].adamage = 0
actors["Void"].level = 0
actors["Void"].experience = 0

actors["Void"].expToLevelUp = 1000
actors["Void"].healthPerLevel = 0
actors["Void"].damagePerLevel = 0
actors["Void"].turnspeedPerLevel = 0

actors["Void"].isDead = 1

--that's how you do it!!!!
--[[
function actorsAnimationsUpdate(dt)

	--check animation timers
	--for i, act in pairs(actors) do
		if actors.Fredbear.timers.currentAnim > 0 then
			actors.Fredbear.timers.currentAnim = actors.Fredbear.timers.currentAnim - dt
		else
			actors.Fredbear.timers.currentAnim = 0
			--if timer ends go to stuck animation
			if actors.Fredbear.aflags.isWindingUp == 1 and actors.Fredbear.aflags.isWindUpStuck == 1 then
				actors.Fredbear.animation:gotoFrame(1)
				actors.Fredbear.animation = animations.actor_fredbear_windup_stuck
				actors.Fredbear.aflags.isWindingUp = 0
			elseif actors.Fredbear.aflags.isUnwinding == 1 then
				actors.Fredbear.animation:gotoFrame(1)
				actors.Fredbear.animation = animations.actor_fredbear_idle
				actors.Fredbear.aflags.isUnwinding = 0
				actors.Fredbear.aflags.isIdle = 1
			elseif actors.Fredbear.aflags.isAttacking == 1 then
				actors.Fredbear.animation:gotoFrame(1)
				actors.Fredbear.animation = animations.actor_fredbear_idle
				actors.Fredbear.aflags.isAttacking = 0
				actors.Fredbear.aflags.isIdle = 1
			elseif actors.Fredbear.aflags.isGlitching == 1 then
				actors.Fredbear.animation:gotoFrame(1)
				actors.Fredbear.animation = animations.actor_fredbear_idle
				actors.Fredbear.aflags.isGlitching = 0
				actors.Fredbear.aflags.isIdle = 1
			end
			
		end
		
		act.animation:update(dt)
	
	end
	
end

function actorFredbearKeypress(key)
	if gameMode < 1 then
		if key == "escape" then
			gameMode = 0
			canChangeMusic = 1
		end
		--wind up from idle
		if key == "up" and actors.Fredbear.aflags.isIdle == 1 and actors.Fredbear.timers.currentAnim <= 0 then
			actors.Fredbear.animation:gotoFrame(1)
			actors.Fredbear.aflags.isIdle = 0
			actors.Fredbear.aflags.isWindUpStuck = 1
			actors.Fredbear.aflags.isWindingUp = 1
			actors.Fredbear.animation = animations.actor_fredbear_windup
			actors.Fredbear.timers.currentAnim = actors.Fredbear.timers.animation_windup_timer
		end
		--unwind up
		if key == "down" and actors.Fredbear.aflags.isWindUpStuck == 1 and 
		actors.Fredbear.aflags.isWindingUp == 0 and actors.Fredbear.timers.currentAnim <= 0 then
			actors.Fredbear.animation:gotoFrame(1)
			actors.Fredbear.aflags.isWindUpStuck = 0
			actors.Fredbear.aflags.isUnwinding = 1
			actors.Fredbear.animation = animations.actor_fredbear_unwind
			actors.Fredbear.timers.currentAnim = actors.Fredbear.timers.animation_windup_timer
		end
		--attack
		if key == "left" and actors.Fredbear.aflags.isWindUpStuck == 1 and 
		actors.Fredbear.aflags.isWindingUp == 0 and actors.Fredbear.timers.currentAnim <= 0 then
			actors.Fredbear.animation:gotoFrame(1)
			actors.Fredbear.aflags.isWindUpStuck = 0
			actors.Fredbear.aflags.isAttacking = 1
			actors.Fredbear.animation = animations.actor_fredbear_attack
			actors.Fredbear.timers.currentAnim = actors.Fredbear.timers.animation_attack_timer
		end
		--glitch
		if key == "right" then
			actors.Fredbear.animation:gotoFrame(1)
			actors.Fredbear.aflags.isIdle = 0
			actors.Fredbear.aflags.isWindingUp = 0
			actors.Fredbear.aflags.isWindUpStuck = 0
			actors.Fredbear.aflags.isUnwinding = 0
			actors.Fredbear.aflags.isAttacking = 0
			actors.Fredbear.aflags.isGlitching = 1
			actors.Fredbear.animation = animations.actor_fredbear_glitch
			actors.Fredbear.timers.currentAnim = actors.Fredbear.timers.animation_glitch_timer
		end
		if key == "space" then

		end
	end
end

function actorsDraw()
	actors["Freddy"].animation:draw(sprites["Actor"]["Freddy"], 0, 0, 0, 1, nil)
 end

]]--

