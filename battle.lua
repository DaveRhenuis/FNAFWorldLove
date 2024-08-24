--This is where we have the actual actors for the battle
battleactors = {}
battleenemies = {}

battleisover = false
battleended = false
yugiohhp2stop = false
yugiohhp1stop = false
victorySFX = {}
victory = {}
victory.timer = 0
xpPool = 0
fazTokens = 0
xpGained = 0
fazTokensGained = 0

levelUpObjects = {}

camLookAtBattleX = (love.graphics.getWidth() / 2)
camLookAtBattleY = (love.graphics.getHeight() / 2)
camLookingRNX = camLookAtBattleX 
camLookingRNY = camLookAtBattleY

shakeScreen = {}
shakeScreen.timer = 0
hitOrangeOverlay = {}
hitOrangeOverlay.timer = 0

--creating the actors, wich are objects with a body that changes skins according to each party member,
--and they inherit they actor stats etc

for i = 1, 4 do
	battleactors[i] = {}
	if i == 1 then
		battleactors[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.30), (love.graphics.getHeight() * 0.50), 
		80, 120, {collision_class = 'Actor'})
	elseif i == 2 then
		battleactors[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.20), (love.graphics.getHeight() * 0.40), 
		80, 120, {collision_class = 'Actor'})
	elseif i == 3 then
		battleactors[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.20), (love.graphics.getHeight() * 0.60), 
		80, 120, {collision_class = 'Actor'})
	elseif i == 4 then
		battleactors[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.10), (love.graphics.getHeight() * 0.50), 
		80, 120, {collision_class = 'Actor'})
	end
	
	battleactors[i]:setType('static')
	battleactors[i].id = player.currentParty[i]
	battleactors[i].currentAnimation = animations["Actor"][player.currentParty[i]]["Idle"]
	battleactors[i].currentSpritesheet = sprites["Actor"][battleactors[i].id]
	battleactors[i].animationTimer = actors[battleactors[i].id].attackTimer
	battleactors[i].animationCurrentTimer = 0
	battleactors[i].turnspeed = actors[player.currentParty[i]].turnspeed
	battleactors[i].MAXhealth = actors[player.currentParty[i]].MAXhealth
	battleactors[i].currentHealth = actors[player.currentParty[i]].currentHealth
	battleactors[i].adamage = actors[player.currentParty[i]].adamage
	battleactors[i].turntimer = 0
	battleactors[i].attackpanelopen = false
	battleactors[i].turnjustended = false
	battleactors[i].turnjustendedTimer = 0
	battleactors[i].buttonAnimOffset = 0
	battleactors[i].lastusedability = "Void"
	battleactors[i].index = i
	battleactors[i].aflags = {}
	battleactors[i].aflags.isIdle = 1
	battleactors[i].aflags.isAttacking = 0
	battleactors[i].aflags.isDead = actors[battleactors[i].id].isDead
	battleactors[i].buttons = {}
	
	--creating the buttons!
	for j = 1, 4 do
		battleactors[i].buttons[j] = worldBattle:newRectangleCollider((battleactors[i].body:getX() + 50 + (15 * j)), 
		(battleactors[i].body:getY() - 10 + (-45 * j)), 190, 30, {collision_class = 'Button'})
		battleactors[i].buttons[j]:setType('static')
		battleactors[i].buttons[j].id = actors[player.currentParty[i]]["Attacks"][j]
		battleactors[i].buttons[j].buttontype = "Actor Attack"
		battleactors[i].buttons[j].actorId = battleactors[i].id
		battleactors[i].buttons[j].atype = abilities[battleactors[i].buttons[j].id].atype
		battleactors[i].buttons[j].isAOE = abilities[battleactors[i].buttons[j].id].isAOE
		battleactors[i].buttons[j].requireTarget = abilities[battleactors[i].buttons[j].id].requireTarget
		battleactors[i].buttons[j].rollcolorRed = abilities[battleactors[i].buttons[j].id].red
		battleactors[i].buttons[j].rollcolorGreen = abilities[battleactors[i].buttons[j].id].green
		battleactors[i].buttons[j].rollcolorBlue = abilities[battleactors[i].buttons[j].id].blue
		battleactors[i].buttons[j].rollcolorAlpha = abilities[battleactors[i].buttons[j].id].alpha
		
	end
	
	battleactors[i].offsetX = actors[player.currentParty[i]].offsetXbattle
	battleactors[i].offsetY = actors[player.currentParty[i]].offsetYbattle
	
end

for i = 1, 4 do
	battleenemies[i] = {}
	if i == 1 then
		battleenemies[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.60), (love.graphics.getHeight() * 0.50), 
		80, 120, {collision_class = 'Enemy'})
	elseif i == 2 then
		battleenemies[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.70), (love.graphics.getHeight() * 0.40), 
		80, 120, {collision_class = 'Enemy'})
	elseif i == 3 then
		battleenemies[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.70), (love.graphics.getHeight() * 0.60), 
		80, 120, {collision_class = 'Enemy'})
	elseif i == 4 then
		battleenemies[i] = worldBattle:newRectangleCollider((love.graphics.getWidth() * 0.80), (love.graphics.getHeight() * 0.50), 
		80, 120, {collision_class = 'Enemy'})
	end
	battleenemies[i]:setType('static')
	battleenemies[i].id = enemyparty[1 --[[THIS WILL BE A RANDOM NUMBER]]][i]
	battleenemies[i].currentAnimation = animations["Enemy"][battleenemies[i].id]
	battleenemies[i].currentSpritesheet = sprites["Enemy"][battleenemies[i].id]
	battleenemies[i].turnspeed = enemies[enemyparty[1][i]].turnspeed + math.random(0, 5)
	battleenemies[i].level = enemies[battleenemies[i].id].level + math.random(0, 4)
	battleenemies[i].xpbase = enemies[battleenemies[i].id].xpbase
	battleenemies[i].MAXhealth = enemies[battleenemies[i].id].MAXhealth + ((battleenemies[i].level) * 5)
	battleenemies[i].currentHealth = battleenemies[i].MAXhealth
	battleenemies[i].adamage = enemies[battleenemies[i].id].adamage

	battleenemies[i].turntimer = 0
	battleenemies[i].index = i

	battleenemies[i].eflags = {}
	battleenemies[i].eflags.isIdle = 1
	battleenemies[i].eflags.isAttacking = 0
	if battleenemies[i].id == "Void" then
		battleenemies[i].eflags.isDead = 1
	else
		battleenemies[i].eflags.isDead = 0
	end
	

	battleenemies[i].offsetX = enemies[enemyparty[1][i]].offsetXbattle
	battleenemies[i].offsetY = enemies[enemyparty[1][i]].offsetYbattle
end

--put this update last
function battleUpdate(dt)
	
	--to check if we can update the buttons
	local canUpdateButtons = false
	
	--timers after the player pressed a button and perform an action
	for i = 1, 4 do
		if battleactors[i].animationCurrentTimer > 0 then
			battleactors[i].animationCurrentTimer = battleactors[i].animationCurrentTimer - dt
		else
			battleactors[i].animationCurrentTimer = 0
			battleactors[i].currentAnimation = animations["Actor"][battleactors[i].id]["Idle"]
			animations["Actor"][battleactors[i].id]["Attack"]:gotoFrame(1)
		end
	end
	
	--update the current animations of the actors
	local alreadyUpdatedAnim = {}
	
	--this is to update the actors sprites, checking dor duplicates
	for i = 1, 4 do
		if battleactors[i].aflags.isDead == 0 then
			local canUpdateAnim = true
			for j = 1, #alreadyUpdatedAnim do
				if battleactors[i].id == alreadyUpdatedAnim[j] then
					canUpdateAnim = false
				end
			end
			if canUpdateAnim == true then
				battleactors[i].currentAnimation:update(dt)
				alreadyUpdatedAnim[i] = battleactors[i].id
			end
		end
	end
	
	--update the current animations of the enemies
	local alreadyUpdatedAnimEnemy = {}
	for i = 1, 4 do
		if battleenemies[i].eflags.isDead == 0 then
			local canUpdateAnimEnemy = true
			for j = 1, #alreadyUpdatedAnimEnemy do
				if battleenemies[i].id == alreadyUpdatedAnimEnemy[j] then
					canUpdateAnimEnemy = false
				end
			end
			if canUpdateAnimEnemy == true then
				battleenemies[i].currentAnimation:update(dt)
				alreadyUpdatedAnimEnemy[i] = battleenemies[i].id
			end
		end
	end
	
	--logic for the turn time and buttons attack panel
	for i = 1, 4 do
		if battleactors[i].turntimer < 200 then
			battleactors[i].turntimer = battleactors[i].turntimer + (dt * battleactors[i].turnspeed)
		elseif battleactors[i].turntimer > 200 then
			battleactors[i].turntimer = 200
		end
		if battleactors[i].attackpanelopen == true then
			canUpdateButtons = true
		end
	end
	
	--logic for the turn time ENEMY!!!!
	for i = 1, 4 do
		if battleenemies[i].eflags.isDead == 0 then
			if battleenemies[i].turntimer < 200 then
				battleenemies[i].turntimer = battleenemies[i].turntimer + (dt * battleenemies[i].turnspeed)
			elseif battleenemies[i].turntimer > 200 then
				battleenemies[i].turntimer = 200
			end
			if battleenemies[i].turntimer > 100 then
				local roll = math.random(0, 199)
				if battleenemies[i].turntimer == 200 then
					roll = 0
				else
					roll = roll - battleenemies[i].level
				end
				
				if roll < 1 then
					local currentAttackIndex = math.random(1, #enemies[battleenemies[i].id]["Attacks"])
					
					if enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].requireTarget == true then
						local target = enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].range[math.random(1, 4)]
						if battleactors[target].aflags.isDead == 1 then
							for j = 1, 4 do
								if battleactors[enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].range[j]].aflags.isDead == 0 then
									target = enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].range[j]
									break
								end
							end
						end
						if battleactors[target].aflags.isDead == 0 then
							enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].script(battleenemies[i], battleactors[target])
							battleenemies[i].turntimer = battleenemies[i].turntimer - enemyabilities[enemies[battleenemies[i].id]["Attacks"][currentAttackIndex]].abilityCost
						end
					end
				end
			end
		end
	end
	
	if canUpdateButtons == true then
		animations["Buttons"]["Transparent Body"]:update(dt)
		animations["Buttons"]["Type Mask"]:update(dt)
	end
	
	for i = 1, 4 do
		if battleactors[i].attackpanelopen == true then
			if battleactors[i].buttonAnimOffset > 0 then
				battleactors[i].buttonAnimOffset = battleactors[i].buttonAnimOffset - (dt * 240)
			else
				battleactors[i].buttonAnimOffset = 0
			end
		end
		if battleactors[i].turnjustended == true then
			animations["Buttons"]["Unused Button"]:update(dt)
			animations["Buttons"]["Used Button"]:update(dt)
			if battleactors[i].turnjustendedTimer > 0 and battleactors[i].turnjustended == true then
				battleactors[i].turnjustendedTimer = battleactors[i].turnjustendedTimer - dt
			elseif battleactors[i].turnjustended == true then
				battleactors[i].turnjustendedTimer = 0
				battleactors[i].turnjustended = false
			end
		end
	end
	
	--SHAKE THE SCREEN!!!!!
	if shakeScreen.timer > 0 then
		shakeScreen.timer = shakeScreen.timer - dt
		camLookingRNX = math.random(camLookAtBattleX - 5, camLookAtBattleX + 5)
		camLookingRNY = math.random(camLookAtBattleY - 5, camLookAtBattleY)
	else 
		shakeScreen.timer = 0
		camLookingRNX = camLookAtBattleX
		camLookingRNY = camLookAtBattleY
	end
	
	if hitOrangeOverlay.timer > 0 then
		hitOrangeOverlay.timer = hitOrangeOverlay.timer - dt
	else
		hitOrangeOverlay.timer = 0
	end
	
	if battleisover == true and victorySFX.body then
		animations["SFX"]["Victory"]:update(dt)
		local vicPosX = victorySFX.body:getX()
		if vicPosX > love.graphics.getWidth() * 0.70 then
			victorySFX.body:setLinearVelocity(-400, 0)
		else
			victorySFX.body:setLinearVelocity(0, 0)
			if victory.timer == 0 then
				local subtractedXP = 0
				local subtractedFazTokens = 0
				if xpGained > 0 then
					if xpGained > 10000 then
						subtractedXP = 1000
					elseif xpGained > 1000 then
						subtractedXP = 100
					elseif xpGained > 100 then
						subtractedXP = 10
					else
						subtractedXP = 1
					end
					xpGained = xpGained - subtractedXP
					for i = 1, 4 do
						if not(battleactors[i].id == "Void") then
							if actors[battleactors[i].id].level <= 19 then
								actors[battleactors[i].id].experience = actors[battleactors[i].id].experience + subtractedXP
								if actors[battleactors[i].id].experience >= actors[battleactors[i].id].expToLevelUp then
									actors[battleactors[i].id].experience = 0
									actors[battleactors[i].id].level = actors[battleactors[i].id].level + 1
									actors[battleactors[i].id].expToLevelUp = actors[battleactors[i].id].expToLevelUp + math.floor(actors[battleactors[i].id].expToLevelUp * 0.3)
									actors[battleactors[i].id].turnspeed = actors[battleactors[i].id].turnspeed + actors[battleactors[i].id].turnspeedPerLevel
									actors[battleactors[i].id].MAXhealth = actors[battleactors[i].id].MAXhealth + actors[battleactors[i].id].healthPerLevel
									actors[battleactors[i].id].currentHealth = actors[battleactors[i].id].MAXhealth
									actors[battleactors[i].id].adamage = actors[battleactors[i].id].adamage + actors[battleactors[i].id].damagePerLevel
									playLevelUpSFX(battleactors[i].body)
								end
							end
						end
					end
				else
					xpGained = 0
				end
				if fazTokensGained > 0 then
					if fazTokensGained > 1000 then
						subtractedFazTokens = 100
					elseif fazTokensGained > 100 then
						subtractedFazTokens = 10
					else
						subtractedFazTokens = 1
					end
					fazTokensGained = fazTokensGained - subtractedFazTokens
				else
					fazTokensGained = 0
				end
				if xpGained == 0 and fazTokensGained == 0 and yugiohhp2stop == false then
					sounds["SFX"]["Yugiohp1"]:stop()
					sounds["SFX"]["Yugiohp2"]:play()
					yugiohhp2stop = true
				end
			end
		end
	end
	
	if victory.timer > 0 and battleisover == true and victorySFX.body then
		victory.timer = victory.timer - dt
	elseif yugiohhp1stop == false and battleisover == true and victorySFX.body then
		victory.timer = 0 
		sounds["SFX"]["Yugiohp1"]:play()
		yugiohhp1stop = true
	end
	
	--timing the hit indicators and cleaning the tables!!!
		if #levelUpObjects > 0 then
			animations["SFX"]["Level Up"]:update(dt)
			for i = 1, #levelUpObjects do
				if levelUpObjects[i].timerToDisappear > 0 then
					levelUpObjects[i].timerToDisappear = levelUpObjects[i].timerToDisappear - dt
					levelUpObjects[i].body:setLinearVelocity(0, -100)
				else
					levelUpObjects[i].timerToDisappear = 0
				end
			end
		end
		
		if #levelUpObjects > 0 then
			for i = #levelUpObjects, 1, -1 do
				if levelUpObjects[i].timerToDisappear <= 0 then
					levelUpObjects[i].body:destroy()
					table.remove(levelUpObjects, i)
				end
			end
		end
	
end

function battleDraw()
	love.graphics.draw(sprites["Background"][player.currentzone], 0, 0, 0, scale["Background"]["X"], scale["Background"]["Y"])
	
	--attacks between background and actor 2
	
	--==========================================FOR ACTORS!!!!!!!!!!!!!!!
	--for every current party member
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				--if it is pizza and is between background and actor 2
				if attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.40) then
					attacks["Actor"][player.currentParty[i]][j].animation:draw(sprites["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname],
					attacks["Actor"][player.currentParty[i]][j].body:getX(), attacks["Actor"][player.currentParty[i]][j].body:getY(),
					0, scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["X"] * -1, 
					scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["Y"], attacks["Actor"][player.currentParty[i]][j].width,
					attacks["Actor"][player.currentParty[i]][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between background and actor 2 ****REMEMBER TO RESCALE THIS!!!!!!!!!!
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].hasSFX == true and 
				attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.40) then
					abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxanimation:draw(sprites["SFX"][abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxname],
					attacks["Actor"][player.currentParty[i]][j].body:getX() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetX,
					attacks["Actor"][player.currentParty[i]][j].body:getY() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	--===========================================FOR ENEMIES!!!!!!!!!!!!!!!!
	--for every current party member
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Enemy"][i] do
				--if it is pizza and is between background and actor 2
				if attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.40) then
					attacks["Enemy"][i][j].animation:draw(sprites["Attacks"][attacks["Enemy"][i][j].atkname],
					attacks["Enemy"][i][j].body:getX(), attacks["Enemy"][i][j].body:getY(),
					0, scale["Attacks"][attacks["Enemy"][i][j].atkname]["X"], 
					scale["Attacks"][attacks["Enemy"][i][j].atkname]["Y"], attacks["Enemy"][i][j].width,
					attacks["Enemy"][i][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between background and actor 2 ************REMEMBER TO RESCALE THIS!!!!!!!!!!
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
			for j = 1, #attacks["Enemy"][i] do
				if enemyabilities[attacks["Enemy"][i][j].atkname].hasSFX == true and 
				attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.40) then
					enemyabilities[attacks["Enemy"][i][j].atkname].sfxanimation:draw(sprites["SFX"][enemyabilities[attacks["Enemy"][i][j].atkname].sfxname],
					attacks["Enemy"][i][j].body:getX() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetX,
					attacks["Enemy"][i][j].body:getY() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	--actor 2 draw
	if battleactors[2].aflags.isDead == 0 then
		battleactors[2].currentAnimation:draw(battleactors[2].currentSpritesheet, battleactors[2].body:getX(), 
		battleactors[2].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleactors[2].offsetX, battleactors[2].offsetY)
	elseif battleactors[2].aflags.isDead == 1 then
		love.graphics.draw(sprites["Actor"]["RIP"], battleactors[2].body:getX(), 
		battleactors[2].body:getY(), 0, 1, 1, (love.graphics.getWidth() * 0.04), (love.graphics.getHeight() * 0.07))
	end
	
	battleenemies[2].currentAnimation:draw(battleenemies[2].currentSpritesheet, battleenemies[2].body:getX(), 
	battleenemies[2].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleenemies[2].offsetX, battleenemies[2].offsetY)
	
	--attacks between actors 2 and 1/4
	
	--==========================================FOR ACTORS!!!!!!!!!!!!!!!!!!!!!!!
	
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				--if it is pizza and is between actor 2 and actors 1/4
				if attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.40) and 
				attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.50) then
					attacks["Actor"][player.currentParty[i]][j].animation:draw(sprites["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname],
					attacks["Actor"][player.currentParty[i]][j].body:getX(), attacks["Actor"][player.currentParty[i]][j].body:getY(),
					0, scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["X"] * -1, 
					scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["Y"], attacks["Actor"][player.currentParty[i]][j].width,
					attacks["Actor"][player.currentParty[i]][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between actors 2 and 1/4
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].hasSFX == true and 
				attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.40) and 
				attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.50) then
					abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxanimation:draw(sprites["SFX"][abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxname],
					attacks["Actor"][player.currentParty[i]][j].body:getX() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetX,
					attacks["Actor"][player.currentParty[i]][j].body:getY() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	--===========================================FOR ENEMIES!!!!!!!!!!!!!!!!
	--for every current party member
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Enemy"][i] do
				--if it is pizza and is between background and actor 2
				if attacks["Enemy"][i][j].depthY >= (love.graphics.getHeight() * 0.40) and 
				attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.50) then
					attacks["Enemy"][i][j].animation:draw(sprites["Attacks"][attacks["Enemy"][i][j].atkname],
					attacks["Enemy"][i][j].body:getX(), attacks["Enemy"][i][j].body:getY(),
					0, scale["Attacks"][attacks["Enemy"][i][j].atkname]["X"], 
					scale["Attacks"][attacks["Enemy"][i][j].atkname]["Y"], attacks["Enemy"][i][j].width,
					attacks["Enemy"][i][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between background and actor 2 ************REMEMBER TO RESCALE THIS!!!!!!!!!!
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
			for j = 1, #attacks["Enemy"][i] do
				if enemyabilities[attacks["Enemy"][i][j].atkname].hasSFX == true and 
				attacks["Enemy"][i][j].depthY >= (love.graphics.getHeight() * 0.40) and 
				attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.50) then
					enemyabilities[attacks["Enemy"][i][j].atkname].sfxanimation:draw(sprites["SFX"][enemyabilities[attacks["Enemy"][i][j].atkname].sfxname],
					attacks["Enemy"][i][j].body:getX() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetX,
					attacks["Enemy"][i][j].body:getY() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================

	--actors 1 and 4 draw
	if battleactors[1].aflags.isDead == 0 then
		battleactors[1].currentAnimation:draw(battleactors[1].currentSpritesheet, battleactors[1].body:getX(), 
		battleactors[1].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleactors[1].offsetX, battleactors[1].offsetY)
	elseif battleactors[1].aflags.isDead == 1 then
		love.graphics.draw(sprites["Actor"]["RIP"], battleactors[1].body:getX(), 
		battleactors[1].body:getY(), 0, 1, 1, (love.graphics.getWidth() * 0.04), (love.graphics.getHeight() * 0.07))
	end
	
	battleenemies[1].currentAnimation:draw(battleenemies[1].currentSpritesheet, battleenemies[1].body:getX(), 
	battleenemies[1].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleenemies[1].offsetX, battleenemies[1].offsetY)
	
	if battleactors[4].aflags.isDead == 0 then
		battleactors[4].currentAnimation:draw(battleactors[4].currentSpritesheet, battleactors[4].body:getX(), 
		battleactors[4].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleactors[4].offsetX, battleactors[4].offsetY)
	elseif battleactors[4].aflags.isDead == 1 then
		love.graphics.draw(sprites["Actor"]["RIP"], battleactors[4].body:getX(), 
		battleactors[4].body:getY(), 0, 1, 1, (love.graphics.getWidth() * 0.04), (love.graphics.getHeight() * 0.07))
	end
	
	battleenemies[4].currentAnimation:draw(battleenemies[4].currentSpritesheet, battleenemies[4].body:getX(), 
	battleenemies[4].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleenemies[4].offsetX, battleenemies[4].offsetY)
	
	--attacks between actors 1/4 and 3
	
	--=============================================================================================================================
	--=========================================FOR ACTORS!!!!!!!!!!!!!!!!!!!!!!!!
	
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			--iterate through every attack
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				--if it is pizza and is between actors 1/4 and 3
				if attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.50) and 
				attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.60) then
					attacks["Actor"][player.currentParty[i]][j].animation:draw(sprites["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname],
					attacks["Actor"][player.currentParty[i]][j].body:getX(), attacks["Actor"][player.currentParty[i]][j].body:getY(),
					0, scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["X"] * -1, 
					scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["Y"], attacks["Actor"][player.currentParty[i]][j].width
					, attacks["Actor"][player.currentParty[i]][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between actors 1/4 and 3
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].hasSFX == true and 
				attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.50) and 
				attacks["Actor"][player.currentParty[i]][j].depthY < (love.graphics.getHeight() * 0.60) then
					abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxanimation:draw(sprites["SFX"][abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxname],
					attacks["Actor"][player.currentParty[i]][j].body:getX() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetX,
					attacks["Actor"][player.currentParty[i]][j].body:getY() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	--===========================================FOR ENEMIES!!!!!!!!!!!!!!!!
	--for every current party member
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Enemy"][i] do
				--if it is pizza and is between background and actor 2
				if attacks["Enemy"][i][j].depthY >= (love.graphics.getHeight() * 0.50) and 
				attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.60) then
					attacks["Enemy"][i][j].animation:draw(sprites["Attacks"][attacks["Enemy"][i][j].atkname],
					attacks["Enemy"][i][j].body:getX(), attacks["Enemy"][i][j].body:getY(),
					0, scale["Attacks"][attacks["Enemy"][i][j].atkname]["X"], 
					scale["Attacks"][attacks["Enemy"][i][j].atkname]["Y"], attacks["Enemy"][i][j].width,
					attacks["Enemy"][i][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between background and actor 2 ************REMEMBER TO RESCALE THIS!!!!!!!!!!
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
			for j = 1, #attacks["Enemy"][i] do
				if enemyabilities[attacks["Enemy"][i][j].atkname].hasSFX == true and 
				attacks["Enemy"][i][j].depthY >= (love.graphics.getHeight() * 0.50) and 
				attacks["Enemy"][i][j].depthY < (love.graphics.getHeight() * 0.60) then
					enemyabilities[attacks["Enemy"][i][j].atkname].sfxanimation:draw(sprites["SFX"][enemyabilities[attacks["Enemy"][i][j].atkname].sfxname],
					attacks["Enemy"][i][j].body:getX() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetX,
					attacks["Enemy"][i][j].body:getY() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	
	--actor 3 draw
	if battleactors[3].aflags.isDead == 0 then
		battleactors[3].currentAnimation:draw(battleactors[3].currentSpritesheet, battleactors[3].body:getX(), 
		battleactors[3].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleactors[3].offsetX, battleactors[3].offsetY)
	elseif battleactors[3].aflags.isDead == 1 then
		love.graphics.draw(sprites["Actor"]["RIP"], battleactors[3].body:getX(), 
		battleactors[3].body:getY(), 0, 1, 1, (love.graphics.getWidth() * 0.04), (love.graphics.getHeight() * 0.07))
	end
	
	battleenemies[3].currentAnimation:draw(battleenemies[3].currentSpritesheet, battleenemies[3].body:getX(), 
	battleenemies[3].body:getY(), 0, (scale["Actors"]["Battle"]["X"] * -1), scale["Actors"]["Battle"]["Y"], battleenemies[3].offsetX, battleenemies[3].offsetY)
	
	--=============================================================================================================================
	--===================================================FOR ACTORS!!!!!!!!!!!!!!!
	
	--attacks in front of all actors
	--for every current party member
	for i = 1, 4 do
		--iterate through every attack
		
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				--if it is pizza and is in front of actor 3
				if attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.60) then
					attacks["Actor"][player.currentParty[i]][j].animation:draw(sprites["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname],
					attacks["Actor"][player.currentParty[i]][j].body:getX(), attacks["Actor"][player.currentParty[i]][j].body:getY(),
					0, scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["X"] * -1, 
					scale["Attacks"][attacks["Actor"][player.currentParty[i]][j].atkname]["Y"], attacks["Actor"][player.currentParty[i]][j].width
					, attacks["Actor"][player.currentParty[i]][j].height)
				end
			end
		end
	end
	
	--sfx animation draw in front!!
	for i = 1, 4 do
		if #attacks["Actor"][player.currentParty[i]] > 0 then
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].hasSFX == true and 
				attacks["Actor"][player.currentParty[i]][j].depthY >= (love.graphics.getHeight() * 0.60) then
					abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxanimation:draw(sprites["SFX"][abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxname],
					attacks["Actor"][player.currentParty[i]][j].body:getX() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetX,
					attacks["Actor"][player.currentParty[i]][j].body:getY() + abilities[attacks["Actor"][player.currentParty[i]][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	--===========================================FOR ENEMIES!!!!!!!!!!!!!!!!
	--for every current party member
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
		--iterate through every attack
			for j = 1, #attacks["Enemy"][i] do
				--if it is pizza and is between background and actor 2
				if attacks["Enemy"][i][j].depthY > (love.graphics.getHeight() * 0.60) then
					attacks["Enemy"][i][j].animation:draw(sprites["Attacks"][attacks["Enemy"][i][j].atkname],
					attacks["Enemy"][i][j].body:getX(), attacks["Enemy"][i][j].body:getY(),
					0, scale["Attacks"][attacks["Enemy"][i][j].atkname]["X"], 
					scale["Attacks"][attacks["Enemy"][i][j].atkname]["Y"], attacks["Enemy"][i][j].width,
					attacks["Enemy"][i][j].height)
				end
			end
		end
	end
	
	--sfx animation draw between background and actor 2 ************REMEMBER TO RESCALE THIS!!!!!!!!!!
	for i = 1, 4 do
		if #attacks["Enemy"][i] > 0 then
			for j = 1, #attacks["Enemy"][i] do
				if enemyabilities[attacks["Enemy"][i][j].atkname].hasSFX == true and 
				attacks["Enemy"][i][j].depthY > (love.graphics.getHeight() * 0.60) then
					enemyabilities[attacks["Enemy"][i][j].atkname].sfxanimation:draw(sprites["SFX"][enemyabilities[attacks["Enemy"][i][j].atkname].sfxname],
					attacks["Enemy"][i][j].body:getX() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetX,
					attacks["Enemy"][i][j].body:getY() + enemyabilities[attacks["Enemy"][i][j].atkname].sfxoffsetY,
					0, 1, 1)
				end
			end
		end
	end
	--=============================================================================================================================
	
	--BUTTONS!!!
	for i = 1, 4 do 
		for j = 1, 4 do
			if battleactors[i].turntimer >= 100 and battleactors[i].attackpanelopen == true then
				love.graphics.setColor(battleactors[i].buttons[j].rollcolorRed, battleactors[i].buttons[j].rollcolorGreen, 
				battleactors[i].buttons[j].rollcolorBlue, battleactors[i].buttons[j].rollcolorAlpha)
				animations["Buttons"]["Type Mask"]:draw(sprites["Buttons"]["Type Mask"], battleactors[i].buttons[j].body:getX(),
				battleactors[i].buttons[j].body:getY(), 0, -1, 1, 104 + battleactors[i].buttonAnimOffset, 25)
				love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
				animations["Buttons"]["Transparent Body"]:draw(sprites["Buttons"]["Transparent Body"], battleactors[i].buttons[j].body:getX(),
				battleactors[i].buttons[j].body:getY(), 0, -1, 1, 104 + battleactors[i].buttonAnimOffset, 25)
				love.graphics.setFont(SegoeUI["017"])
				love.graphics.print(battleactors[i].buttons[j].id, battleactors[i].buttons[j].body:getX(), 
				battleactors[i].buttons[j].body:getY(), 0, 1, 1, abilities[battleactors[i].buttons[j].id].offsetX - battleactors[i].buttonAnimOffset, 
				abilities[battleactors[i].buttons[j].id].offsetY)
				love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
			elseif battleactors[i].turnjustended == true and not(battleactors[i].lastusedability == battleactors[i].buttons[j].id) then
				animations["Buttons"]["Unused Button"]:draw(sprites["Buttons"]["Unused Button"], battleactors[i].buttons[j].body:getX(),
				battleactors[i].buttons[j].body:getY(), 0, -1, 1, 104 + battleactors[i].buttonAnimOffset, 25)
			elseif battleactors[i].turnjustended == true and battleactors[i].lastusedability == battleactors[i].buttons[j].id then
				animations["Buttons"]["Used Button"]:draw(sprites["Buttons"]["Used Button"], battleactors[i].buttons[j].body:getX(),
				battleactors[i].buttons[j].body:getY(), 0, -1 * 0.65, 0.65, 170 + battleactors[i].buttonAnimOffset, 40)
			end
		end
	end
end

function battleDrawOverhud()
	--[[
	FOR DEBUGGING !!!!
	--enemies current health
	for i = 1, 4 do
		if not(battleenemies[i].id == "Void") and battleenemies[i].eflags.isDead == 0 then
			love.graphics.setFont(LcdSolid["017"])
			love.graphics.print(battleenemies[i].currentHealth, battleenemies[i].body:getX() - 20, battleenemies[i].body:getY() - 20,
			0, 1, 1)		
			love.graphics.setFont(LcdSolid["017"])
			love.graphics.print(math.floor(battleenemies[i].turntimer / 2) .. "%", battleenemies[i].body:getX() + 50, battleenemies[i].body:getY())
		end
	end
	
	for i = 1, 4 do
		if not(battleactors[i].id == "Void") then
			love.graphics.print(battleactors[i].id .. " " .. actors[battleactors[i].id].experience, 0 + (i * 150), 100)
		end
	end
	
	]]--
	for i = 1, 4 do
		--show the turn timer!!!
		if not(battleactors[i].id == "Void") and battleactors[i].aflags.isDead == 0 then
			love.graphics.setFont(LcdSolid["017"])
			love.graphics.print(math.floor(battleactors[i].turntimer / 2) .. "%", battleactors[i].body:getX() + 50, battleactors[i].body:getY())
		end
	end
	--draw hit, damage and death effects
	if #damageIndicatorObjects > 0 then
		for i = 1, #damageIndicatorObjects do
			love.graphics.setFont(SegoeUI["03"])
			love.graphics.printf(damageIndicatorObjects[i].damage, damageIndicatorObjects[i].body:getX(), 
			damageIndicatorObjects[i].body:getY(), 120, 'center', 0, 1, 1, 60, 30)
		end
	end
	if #hitIndicatorObjects > 0 then
		for i = 1, #hitIndicatorObjects do
			animations["SFX"]["Damaged Entity"]:draw(sprites["SFX"]["Damaged Entity"], hitIndicatorObjects[i].body:getX(), 
			hitIndicatorObjects[i].body:getY(), 0, 1, 1, 75, 75)
		end
	end
	if #deathIndicatorObjects > 0 then
		for i = 1, #deathIndicatorObjects do
			animations["SFX"]["Death"]:draw(sprites["SFX"]["Death"], deathIndicatorObjects[i].body:getX(), 
			deathIndicatorObjects[i].body:getY(), 0, 1, 1, 150, 150)
		end
	end
	
	--xp and faztokens
	if battleisover == true and victorySFX.body then
		animations["SFX"]["Victory"]:draw(sprites["SFX"]["Victory"], victorySFX.body:getX(), victorySFX.body:getY(), 0,
		scale["Actors"]["Battle"]["X"], scale["Actors"]["Battle"]["Y"], 150, 150)
		love.graphics.setFont(SansationBold["035"])
		love.graphics.printf(fazTokensGained, victorySFX.body:getX(), victorySFX.body:getY(), (love.graphics.getWidth() * 0.25), 'right', 0, 1, 1, (love.graphics.getWidth() * 0.2), (love.graphics.getHeight() * 0.045) * -1)
		love.graphics.printf(xpGained, victorySFX.body:getX(), victorySFX.body:getY(), (love.graphics.getWidth() * 0.25), 'right', 0, 1, 1, (love.graphics.getWidth() * 0.2), (love.graphics.getHeight() * 0.06))
	end
	
	--level up sfx
	if #levelUpObjects > 0 then
		for i = 1, #levelUpObjects do
			animations["SFX"]["Level Up"]:draw(sprites["SFX"]["Level Up"], levelUpObjects[i].body:getX(), 
			levelUpObjects[i].body:getY(), 0, 0.75, 0.75, 120, 75)
		end
	end
	
	--healthbars
	for i = 1, 4 do
		if not(battleactors[i].id == "Void") then
			for j = 1, #sprites["Images"] do
				if sprites["Images"][j].id == battleactors[i].id then
					love.graphics.draw(sprites["Images"][j]["Icon"], ((love.graphics.getWidth() * 0.05) + ((i - 1) * love.graphics.getWidth() * 0.13)), (love.graphics.getHeight() * 0.05),
					0, 0.5, 0.5)
					love.graphics.setColor(1, 0, 0, 1)
					love.graphics.rectangle('fill', ((love.graphics.getWidth() * 0.075) + ((i - 1) * love.graphics.getWidth() * 0.13)), (love.graphics.getHeight() * 0.05),
					((battleactors[i].currentHealth / battleactors[i].MAXhealth) * 130), 35)
					love.graphics.setColor(1, 1, 1, 1)
					love.graphics.setFont(LcdSolid["017"])
					love.graphics.printf(battleactors[i].currentHealth, ((love.graphics.getWidth() * 0.085) + ((i - 1) * love.graphics.getWidth() * 0.13)), 
					(love.graphics.getHeight() * 0.05), 100, 'center', 0, 1, 1, 0, ((love.graphics.getHeight() * 0.01) * -1))
					love.graphics.rectangle('line', ((love.graphics.getWidth() * 0.075) + ((i - 1) * love.graphics.getWidth() * 0.13)), (love.graphics.getHeight() * 0.05),
					130, 35)
				end
			end
		end
	end
	
	--screen orange overlay on hit
	if hitOrangeOverlay.timer > 0 then
		love.graphics.setColor(1, 1, 1, hitOrangeOverlay.timer)
		love.graphics.draw(sprites["SFX"]["Hit Orange Overlay"], 0, 0, 0, scale["Background"]["X"], scale["Background"]["Y"])
	end
	
end

function refreshPartyToSlots()
	for i = 1, 4 do
		battleactors[i].id = player.currentParty[i]
		battleactors[i].currentAnimation = animations["Actor"][battleactors[i].id]["Idle"]
		battleactors[i].currentSpritesheet = sprites["Actor"][battleactors[i].id]
		battleactors[i].animationTimer = actors[battleactors[i].id].attackTimer
		battleactors[i].animationCurrentTimer = 0
		battleactors[i].offsetX = actors[battleactors[i].id].offsetXbattle
		battleactors[i].offsetY = actors[battleactors[i].id].offsetYbattle
		battleactors[i].turnspeed = actors[player.currentParty[i]].turnspeed
		battleactors[i].MAXhealth = actors[player.currentParty[i]].MAXhealth
		battleactors[i].currentHealth = actors[player.currentParty[i]].currentHealth
		battleactors[i].adamage = actors[player.currentParty[i]].adamage
		battleactors[i].turntimer = 0
		battleactors[i].index = i
		battleactors[i].attackpanelopen = false
		battleactors[i].turnjustended = false
		battleactors[i].turnjustendedTimer = 0
		battleactors[i].buttonAnimOffset = 0
		
		battleactors[i].aflags.isIdle = 1
		battleactors[i].aflags.isAttacking = 0
		battleactors[i].aflags.isDead = actors[battleactors[i].id].isDead
		for j = 1, 4 do
			battleactors[i].buttons[j].id = actors[player.currentParty[i]]["Attacks"][j]
			battleactors[i].buttons[j].buttontype = "Actor Attack"
			battleactors[i].buttons[j].actorId = battleactors[i].id
			battleactors[i].buttons[j].atype = abilities[battleactors[i].buttons[j].id].atype
			battleactors[i].buttons[j].isAOE = abilities[battleactors[i].buttons[j].id].isAOE
			battleactors[i].buttons[j].requireTarget = abilities[battleactors[i].buttons[j].id].requireTarget
			battleactors[i].buttons[j].rollcolorRed = abilities[battleactors[i].buttons[j].id].red
			battleactors[i].buttons[j].rollcolorGreen = abilities[battleactors[i].buttons[j].id].green
			battleactors[i].buttons[j].rollcolorBlue = abilities[battleactors[i].buttons[j].id].blue
			battleactors[i].buttons[j].rollcolorAlpha = abilities[battleactors[i].buttons[j].id].alpha
		end
	end
end

--this function should work for any button that I make!!!!!
function battleMousepressed(x, y, button, istouch, presses)
	if button == 1 then
		local interactables = worldBattle:queryCircleArea(x, y, 16, {'Button'})
		if #interactables > 0 then
			local bestDist = 1000
			local actorIndex = 0
			local actorIndexisActive = 0
			
			--check the button that is closer to the mouse query?
			for i, obj in ipairs(interactables) do
				local currentDist = distanceBetween(obj.body:getX(), obj.body:getY(), love.mouse.getX(), love.mouse.getY())
				for j = 1, 4 do
					if battleactors[j].id == obj.actorId then
						actorIndexisActive = j
					end
				end
				if currentDist < bestDist and battleactors[actorIndexisActive].attackpanelopen == true then
					bestDist = currentDist
				end
			end
			
			--cicle trough every button found (on the if statements, we check for ability type, if is aoe,
			--if requires target to work, anything aditional
			for i, obj in ipairs(interactables) do
				--get the button distance
				local objDist = distanceBetween(obj.body:getX(), obj.body:getY(), love.mouse.getX(), love.mouse.getY())
				
				--get the actor the button is from
				
				for j = 1, 4 do
					if battleactors[j].id == obj.actorId then
						actorIndex = j
					end
				end
				
				--if it is the closest button to the mouse
				if objDist <= bestDist then
					if obj.collision_class == "Button" and battleactors[actorIndex].turntimer >= 100 and 
					battleactors[actorIndex].attackpanelopen == true then
						battleactors[actorIndex].currentAnimation = animations["Actor"][battleactors[actorIndex].id]["Attack"]
						battleactors[actorIndex].animationCurrentTimer = battleactors[actorIndex].animationTimer
						animations["Actor"][battleactors[actorIndex].id]["Idle"]:gotoFrame(1)
						--if the type of the button is an actor attack
						if obj.buttontype == "Actor Attack" then
							--if the action is an attack
							if obj.atype == "Attack" then
								--if require a target
								if obj.requireTarget == false then
									--if is an aoe
									if obj.isAOE == true then
										abilities[obj.id].script(obj.actorId, actorIndex)
									end
								end
							end
						end
						--cost according to ability cost
						battleactors[actorIndex].turntimer = battleactors[actorIndex].turntimer - abilities[obj.id].abilityCost
						if battleactors[actorIndex].turntimer < 100 then
							battleactors[actorIndex].lastusedability = obj.id
							battleactors[actorIndex].attackpanelopen = false
							battleactors[actorIndex].turnjustended = true
							animations["Buttons"]["Unused Button"]:gotoFrame(1)
							animations["Buttons"]["Unused Button"]:resume()
							animations["Buttons"]["Used Button"]:gotoFrame(1)
							animations["Buttons"]["Used Button"]:resume()
							battleactors[actorIndex].turnjustendedTimer = 0.34
						end
					end
				end
			end
		end
		
	elseif button == 2 then
	
		local interactables = worldBattle:queryCircleArea(x, y, 60, {'Actor'})
		if #interactables > 0 then
			local bestDist = 1000
			local actorIndex = 0
			
			--check the button that is closer to the mouse query?
			for i, obj in ipairs(interactables) do
				local currentDist = distanceBetween(obj.body:getX(), obj.body:getY(), love.mouse.getX(), love.mouse.getY())
				if currentDist < bestDist then
					bestDist = currentDist
				end
			end
			
			--cicle trough every button found (on the if statements, we check for ability type, if is aoe,
			--if requires target to work, anything aditional
			for i, obj in ipairs(interactables) do
				--get the button distance
				local objDist = distanceBetween(obj.body:getX(), obj.body:getY(), love.mouse.getX(), love.mouse.getY())
				
				--if it is the closest button to the mouse
				if objDist <= bestDist then
					if battleactors[obj.index].turntimer >= 100 and battleactors[obj.index].attackpanelopen == false then
						battleactors[obj.index].attackpanelopen = true
						battleactors[obj.index].buttonAnimOffset = 50
						sounds["SFX"]["Abilities Menu Pop"]:stop()
						sounds["SFX"]["Abilities Menu Pop"]:play()
					elseif battleactors[obj.index].turntimer >= 100 and battleactors[obj.index].attackpanelopen == true then
						battleactors[obj.index].attackpanelopen = false
					end
				end
			end
		end
	end
end

--get the distance between two objects
function distanceBetween(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function shakeScreenFunction(newTimer)
	shakeScreen.timer = newTimer
end

function hitOrangeOverlayFunction(newTimer)
	hitOrangeOverlay.timer = newTimer
end

--CAN CREATE A BATTLE ACCORDING TO REGION ON PARAMETERS
--EDIT THIS WHEN ENEMIES CAN ATTACK AND KILL THE PLAYER
function spawnBattle(--[[REGION]])
	gameMode = 2
	battleisover = false
	yugiohhp1stop = false
	yugiohhp2stop = false
	if victorySFX.body then
		if not(victorySFX.body:isDestroyed()) then
			victorySFX.body:destroy()
		end
	end
	--delete current active attacks for new battle
	for i = 1, 4 do
		--iterate through every attack
		for j = #attacks["Actor"][player.currentParty[i]], 1, -1 do
			attacks["Actor"][player.currentParty[i]][j].body:destroy()
			table.remove(attacks["Actor"][player.currentParty[i]], j)
		end
	end
	--delete current active attacks for new battle ENEMY
	for i = 1, 4 do
		--iterate through every attack
		for j = #attacks["Enemy"][i], 1, -1 do
			attacks["Enemy"][i][j].body:destroy()
			table.remove(attacks["Enemy"][i], j)
		end
	end
	--delete damage indicator for new battle, if any
	if #damageIndicatorObjects > 0 then
		for i = #damageIndicatorObjects, 1, -1 do
			damageIndicatorObjects[i].body:destroy()
			table.remove(damageIndicatorObjects, i)
		end
	end
	--delete damage indicator for new battle, if any
	if #hitIndicatorObjects > 0 then
		for i = #hitIndicatorObjects, 1, -1 do
			hitIndicatorObjects[i].body:destroy()
			table.remove(hitIndicatorObjects, i)
		end
	end
	--delete damage indicator for new battle, if any
	if #deathIndicatorObjects > 0 then
		for i = #deathIndicatorObjects, 1, -1 do
			deathIndicatorObjects[i].body:destroy()
			table.remove(deathIndicatorObjects, i)
		end
	end
	--delete level up objects if any
	if #levelUpObjects > 0 then
		for i = #levelUpObjects, 1, -1 do
			levelUpObjects[i].body:destroy()
			table.remove(levelUpObjects, i)
		end
	end
	shakeScreenFunction(0)
	hitOrangeOverlayFunction(0)
	--loading player chars
	for i = 1, 4 do
		battleactors[i].id = player.currentParty[i]
		battleactors[i].MAXhealth = actors[player.currentParty[i]].MAXhealth
		battleactors[i].adamage = actors[player.currentParty[i]].adamage
		battleactors[i].turntimer = 0
		battleactors[i].index = i
		battleactors[i].attackpanelopen = false
		battleactors[i].turnjustended = false
		battleactors[i].turnjustendedTimer = 0
		battleactors[i].buttonAnimOffset = 0
		if actors[battleactors[i].id].isDead == 0 then
			battleactors[i].currentAnimation = animations["Actor"][battleactors[i].id]["Idle"]
			battleactors[i].currentSpritesheet = sprites["Actor"][battleactors[i].id]
			battleactors[i].animationTimer = actors[battleactors[i].id].attackTimer
			battleactors[i].animationCurrentTimer = 0
			battleactors[i].offsetX = actors[battleactors[i].id].offsetXbattle
			battleactors[i].offsetY = actors[battleactors[i].id].offsetYbattle
			battleactors[i].turnspeed = actors[player.currentParty[i]].turnspeed
			battleactors[i].currentHealth = actors[player.currentParty[i]].currentHealth
			battleactors[i].aflags.isDead = actors[battleactors[i].id].isDead
		elseif actors[battleactors[i].id].isDead == 1 then
			battleactors[i].currentAnimation = animations["Actor"]["Void"]["Idle"]
			battleactors[i].currentSpritesheet = sprites["Actor"]["Void"]
			battleactors[i].animationTimer = actors[battleactors[i].id].attackTimer
			battleactors[i].animationCurrentTimer = 0
			battleactors[i].offsetX = actors[battleactors[i].id].offsetXbattle
			battleactors[i].offsetY = actors[battleactors[i].id].offsetYbattle
			battleactors[i].turnspeed = 0
			battleactors[i].currentHealth = 0
			battleactors[i].aflags.isDead = 1
		end
		for j = 1, 4 do
			battleactors[i].buttons[j].id = actors[player.currentParty[i]]["Attacks"][j]
			battleactors[i].buttons[j].buttontype = "Actor Attack"
			battleactors[i].buttons[j].actorId = battleactors[i].id
			battleactors[i].buttons[j].atype = abilities[battleactors[i].buttons[j].id].atype
			battleactors[i].buttons[j].isAOE = abilities[battleactors[i].buttons[j].id].isAOE
			battleactors[i].buttons[j].requireTarget = abilities[battleactors[i].buttons[j].id].requireTarget
			battleactors[i].buttons[j].rollcolorRed = abilities[battleactors[i].buttons[j].id].red
			battleactors[i].buttons[j].rollcolorGreen = abilities[battleactors[i].buttons[j].id].green
			battleactors[i].buttons[j].rollcolorBlue = abilities[battleactors[i].buttons[j].id].blue
			battleactors[i].buttons[j].rollcolorAlpha = abilities[battleactors[i].buttons[j].id].alpha
		end
	end
	for i = 1, 4 do
		if not(enemyparty[1--[[RANDOM NUMBER]]][i] == "Void") then
			battleenemies[i].id = enemyparty[1 --[[THIS WILL BE A RANDOM NUMBER]]][i]
			battleenemies[i].currentAnimation = animations["Enemy"][battleenemies[i].id]
			battleenemies[i].currentSpritesheet = sprites["Enemy"][battleenemies[i].id]
			battleenemies[i].turnspeed = enemies[enemyparty[1][i]].turnspeed + math.random(0, 5)
			battleenemies[i].level = enemies[battleenemies[i].id].level + math.random(0, 4)
			battleenemies[i].MAXhealth = enemies[battleenemies[i].id].MAXhealth + ((battleenemies[i].level) * 5)
			battleenemies[i].currentHealth = battleenemies[i].MAXhealth
			battleenemies[i].adamage = enemies[battleenemies[i].id].adamage
			battleenemies[i].xpbase = enemies[battleenemies[i].id].xpbase

			battleenemies[i].turntimer = 0
			battleenemies[i].index = i
			if battleenemies[i].id == "Void" then
				battleenemies[i].eflags.isDead = 1
			else
				battleenemies[i].eflags.isDead = 0
			end
			battleenemies[i].eflags.isIdle = 1
			battleenemies[i].eflags.isAttacking = 0

			battleenemies[i].offsetX = enemies[enemyparty[1][i]].offsetXbattle
			battleenemies[i].offsetY = enemies[enemyparty[1][i]].offsetYbattle
		end
	end
end

function checkIfBattleIsOver()
	local enemiesDead = 0
	local endbattle = false
	for i = 1, 4 do
		if battleenemies[i].eflags.isDead == 1 then
			enemiesDead = enemiesDead + 1
		end
	end
	if enemiesDead == 4 then
		endbattle = true
	end
	return endbattle
end

function checkIfGameOver()
	local alliesDead = 0
	local endgame = false
	for i = 1, 4 do
		if battleactors[i].aflags.isDead == 1 then
			alliesDead = alliesDead + 1
		end
	end
	if alliesDead == 4 then
		endgame = true
	end
	return endgame
end

function zeroPlayerTurn()
	for i = 1, 4 do
		battleactors[i].turnspeed = 0
		battleactors[i].turntimer = 0
	end
end

function playLevelUpSFX(body)
	levelUpObject = worldBattle:newRectangleCollider(body:getX() - 20, body:getY() - 20, 40, 40, {collision_class = 'SFX'})
	levelUpObject:setFixedRotation(true)
	levelUpObject.index = body.index
	levelUpObject.timerToDisappear = 1
	table.insert(levelUpObjects, levelUpObject)
	sounds["SFX"]["Yay"]:stop()
	sounds["SFX"]["Yay"]:play()
end