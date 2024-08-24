--current active attacks of every actor
attacks = {}
attacks["Actor"] = {}
attacks["Enemy"] = {}

abilitiesCurrentActive = {}

abilitiesCurrentActiveEnemy = {}

damageIndicatorObjects = {}
hitIndicatorObjects = {}
deathIndicatorObjects = {}

--create a table of current attacks for every actor in the game, wich we will handle during battle
for i, obj in pairs(actors) do
	attacks["Actor"][obj.id] = {}
end

for i = 1, 4 do
	attacks["Enemy"][i] = {}
end

function eventHandler(dt)
	if gameMode == 2 then
	
		--get current active attacks
		--for every current party member
		for i = 1, 4 do
			--iterate through every attack
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				local isOnTheActiveList = false
				for k = 1, #abilitiesCurrentActive do
					--if it is on the current active abilities list
					if attacks["Actor"][player.currentParty[i]][j].atkname == abilitiesCurrentActive[k] then
						isOnTheActiveList = true
					end
				end
				--if the attack is not on the list, put on the list
				if isOnTheActiveList == false then
					table.insert(abilitiesCurrentActive, attacks["Actor"][player.currentParty[i]][j].atkname)
				end
			end
		end
		
		--get inactive attacks and clean the table
		--for every current party member
		for i = 1, 4 do
			--iterate through every attack
			for j = #attacks["Actor"][player.currentParty[i]], 1, -1 do
				local isStillActive = false
				for k = #abilitiesCurrentActive, 1, -1 do
					--if it is on the current active abilities list
					if attacks["Actor"][player.currentParty[i]][j].atkname == abilitiesCurrentActive[k] then
						isStillActive = true
					end
				end
				if isStillActive == false then
					table.remove(abilitiesCurrentActive, k)
				end
			end
		end
		
		--update current active attacks animations
		for i = 1, #abilitiesCurrentActive do
			animations["Attacks"][abilitiesCurrentActive[i]]:update(dt)
			if abilities[abilitiesCurrentActive[i]].hasSFX == true then
				animations["SFX"][abilities[abilitiesCurrentActive[i]].sfxname]:update(dt)
			end
		end
		
		--update current active attacks positions if the attack moves
		for i = 1, 4 do
			for j = 1, #attacks["Actor"][player.currentParty[i]] do
				if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].hasMovement == true then
					abilities[attacks["Actor"][player.currentParty[i]][j].atkname].movement(player.currentParty[i], j)
				end
			end
		end
		
		--=====================================================FOR ENEMY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		
		--get current active attacks
		--for every ENEMY
		for i = 1, 4 do
			--iterate through every attack
			for j = 1, #attacks["Enemy"][i] do
				local isOnTheActiveList = false
				for k = 1, #abilitiesCurrentActiveEnemy do
					--if it is on the current active abilities list
					if attacks["Enemy"][i][j].atkname == abilitiesCurrentActiveEnemy[k] then
						isOnTheActiveList = true
					end
				end
				--if the attack is not on the list, put on the list
				if isOnTheActiveList == false then
					table.insert(abilitiesCurrentActiveEnemy, attacks["Enemy"][i][j].atkname)
				end
			end
		end
		
		--get inactive attacks and clean the table
		--for every current party member
		for i = 1, 4 do
			--iterate through every attack
			for j = #attacks["Enemy"][i], 1, -1 do
				local isStillActive = false
				for k = #abilitiesCurrentActiveEnemy, 1, -1 do
					--if it is on the current active abilities list
					if attacks["Enemy"][i][j].atkname == abilitiesCurrentActiveEnemy[k] then
						isStillActive = true
					end
				end
				if isStillActive == false then
					table.remove(abilitiesCurrentActiveEnemy, k)
				end
			end
		end
		
		--update current active attacks animations
		for i = 1, #abilitiesCurrentActiveEnemy do
			animations["Attacks"][abilitiesCurrentActiveEnemy[i]]:update(dt)
			if enemyabilities[abilitiesCurrentActiveEnemy[i]].hasSFX == true then
				animations["SFX"][enemyabilities[abilitiesCurrentActiveEnemy[i]].sfxname]:update(dt)
			end
		end
		
		--update current active attacks positions if the attack moves
		for i = 1, 4 do
			for j = 1, #attacks["Enemy"][i] do
				if enemyabilities[attacks["Enemy"][i][j].atkname].hasMovement == true then
					enemyabilities[attacks["Enemy"][i][j].atkname].movement(i, j)
				end
			end
		end
		
		--==============================================FOR THE PLAYER!!!!!!!!!!!!
		--this will delete any attack offscreen from every current party member IF PROJECTILE X > SCREEN WIDTH
		for i = 1, 4 do
			--iterate through every attack
			--in reverse order
			for j = #attacks["Actor"][player.currentParty[i]], 1, -1 do
				--if it is a projectile
				if attacks["Actor"][player.currentParty[i]][j].atktype == "projectile" then
					--get projectile X
					local projectileX = attacks["Actor"][player.currentParty[i]][j].body:getX()
					--if it is out of bounds
					if projectileX > love.graphics.getWidth() then
						--destroy the projectile and remove/reorder index
						attacks["Actor"][player.currentParty[i]][j].body:destroy()
						table.remove(attacks["Actor"][player.currentParty[i]], j)
					--else if collides with enemy
					else 
						--check for the closest enemy
						local enteredEnemy = worldBattle:queryRectangleArea(attacks["Actor"][player.currentParty[i]][j].body:getX() - (attacks["Actor"][player.currentParty[i]][j].width / 2), 
						attacks["Actor"][player.currentParty[i]][j].body:getY() - (attacks["Actor"][player.currentParty[i]][j].height / 2), 
						attacks["Actor"][player.currentParty[i]][j].width, attacks["Actor"][player.currentParty[i]][j].height, {'Enemy'})
					
						--if it collides with an enemy
						if #enteredEnemy > 0 then
							--check if already damaged this enemy once
							abilities[attacks["Actor"][player.currentParty[i]][j].atkname].damageScript(enteredEnemy, 
							player.currentParty[i], j)
							if abilities[attacks["Actor"][player.currentParty[i]][j].atkname].isAOE == false then
								attacks["Actor"][player.currentParty[i]][j].body:destroy()
								table.remove(attacks["Actor"][player.currentParty[i]], j)
							end
						end
					end
				end
			end
		end
		--==========================================================================================================================
		--=================================================FOR ENEMIES
		--this will delete any attack offscreen from every current party member IF PROJECTILE X > SCREEN WIDTH
		for i = 1, 4 do
			--iterate through every attack
			--in reverse order
			for j = #attacks["Enemy"][i], 1, -1 do
				--if it is a projectile
				if attacks["Enemy"][i][j].atktype == "projectile" then
					--get projectile X
					local projectileX = attacks["Enemy"][i][j].body:getX()
					--if it is out of bounds
					if projectileX > love.graphics.getWidth() then
						--destroy the projectile and remove/reorder index
						attacks["Enemy"][i][j].body:destroy()
						table.remove(attacks["Enemy"][i], j)
					--else if collides with enemy
					else 
						--check for the closest enemy
						local enteredAlly = worldBattle:queryRectangleArea(attacks["Enemy"][i][j].body:getX() - (attacks["Enemy"][i][j].width / 2), 
						attacks["Enemy"][i][j].body:getY() - (attacks["Enemy"][i][j].height / 2), 
						attacks["Enemy"][i][j].width, attacks["Enemy"][i][j].height, {'Actor'})
					
						--if it collides with an enemy
						if #enteredAlly > 0 then
							--check if already damaged this enemy once
							enemyabilities[attacks["Enemy"][i][j].atkname].damageScript(enteredAlly, 
							i, j)
						end
					end
				elseif attacks["Enemy"][i][j].atktype == "target" then
					if attacks["Enemy"][i][j].timer > 0 then
						attacks["Enemy"][i][j].timer = attacks["Enemy"][i][j].timer - dt
					else
						attacks["Enemy"][i][j].timer = 0
						enemyabilities[attacks["Enemy"][i][j].atkname].damageScript(battleactors[attacks["Enemy"][i][j].target], 
						attacks["Enemy"][i][j])
						attacks["Enemy"][i][j].body:destroy()
						table.remove(attacks["Enemy"][i], j)
					end
				end
			end
		end
		--animating the damage indicators and cleaning the tables!!!
		if #damageIndicatorObjects > 0 then
			for i = 1, #damageIndicatorObjects do
				if damageIndicatorObjects[i].timerToDisappear > 0 then
					damageIndicatorObjects[i].timerToDisappear = damageIndicatorObjects[i].timerToDisappear - dt
					damageIndicatorObjects[i].body:setLinearVelocity(0, -100)
				else
					damageIndicatorObjects[i].timerToDisappear = 0
				end
			end
		end
		
		if #damageIndicatorObjects > 0 then
			for i = #damageIndicatorObjects, 1, -1 do
				if damageIndicatorObjects[i].timerToDisappear <= 0 then
					damageIndicatorObjects[i].body:destroy()
					table.remove(damageIndicatorObjects, i)
				end
			end
		end
		
		--timing the hit indicators and cleaning the tables!!!
		if #hitIndicatorObjects > 0 then
			animations["SFX"]["Damaged Entity"]:update(dt)
			for i = 1, #hitIndicatorObjects do
				if hitIndicatorObjects[i].timerToDisappear > 0 then
					hitIndicatorObjects[i].timerToDisappear = hitIndicatorObjects[i].timerToDisappear - dt
				else
					hitIndicatorObjects[i].timerToDisappear = 0
				end
			end
		end
		
		if #hitIndicatorObjects > 0 then
			for i = #hitIndicatorObjects, 1, -1 do
				if hitIndicatorObjects[i].timerToDisappear <= 0 then
					hitIndicatorObjects[i].body:destroy()
					table.remove(hitIndicatorObjects, i)
				end
			end
		end
		
		--timing the death indicators and cleaning the tables!!!
		if #deathIndicatorObjects > 0 then
			animations["SFX"]["Death"]:update(dt)
			for i = 1, #deathIndicatorObjects do
				if deathIndicatorObjects[i].timerToDisappear > 0 then
					deathIndicatorObjects[i].timerToDisappear = deathIndicatorObjects[i].timerToDisappear - dt
				else
					deathIndicatorObjects[i].timerToDisappear = 0
				end
			end
		end
		
		if #deathIndicatorObjects > 0 then
			for i = #deathIndicatorObjects, 1, -1 do
				if deathIndicatorObjects[i].timerToDisappear <= 0 then
					deathIndicatorObjects[i].body:destroy()
					table.remove(deathIndicatorObjects, i)
				end
			end
		end
		
	end
end

--create a damage indicator on this body
function createDamageIndicator(damage, body)
	damageObject = worldBattle:newRectangleCollider(body:getX() - 20, body:getY() - 20, 40, 40, {collision_class = 'SFX'})
	damageObject:setFixedRotation(true)
	damageObject.timerToDisappear = 1
	damageObject.damage = damage
	table.insert(damageIndicatorObjects, damageObject)
end

--create a hit indicator on this body
function createHitIndicator(body)
	hitObject = worldBattle:newRectangleCollider(body:getX() - 20, body:getY() - 20, 40, 40, {collision_class = 'SFX'})
	hitObject:setFixedRotation(true)
	hitObject.index = body.index
	hitObject.timerToDisappear = 0.27
	animations["SFX"]["Damaged Entity"]:gotoFrame(1)
	animations["SFX"]["Damaged Entity"]:resume()
	table.insert(hitIndicatorObjects, hitObject)
end

--if is dead, change animation, sprite, play effects
function checkIfIsDead(body)
	if body.currentHealth <= 0 then
		body.currentHealth = 0
		if body.collision_class == "Actor" then
			body.aflags.isDead = 1
			--for hardcore people
			--actors[body.id].isDead = 1
			body.turnspeed = 0
			body.turntimer = 0
			body.currentAnimation = animations["Actor"]["Void"]["Idle"]
			body.currentSpritesheet = sprites["Actor"]["Void"] 
		elseif body.collision_class == "Enemy" then
			body.eflags.isDead = 1
			body.turnspeed = 0
			body.turntimer = 0
			body.currentAnimation = animations["Actor"]["Void"]["Idle"]
			body.currentSpritesheet = sprites["Actor"]["Void"] 
		end
		animations["SFX"]["Death"]:gotoFrame(1)
		animations["SFX"]["Death"]:resume()
		sounds["SFX"]["Death"]:stop()
		sounds["SFX"]["Death"]:play()
		deathObject = worldBattle:newRectangleCollider(body:getX() - 20, body:getY() - 20, 40, 40, {collision_class = 'SFX'})
		deathObject:setFixedRotation(true)
		deathObject.index = body.index
		deathObject.timerToDisappear = 0.35
		table.insert(deathIndicatorObjects, deathObject)
	end
	
	battleisover = checkIfBattleIsOver()
	
	if battleisover == true then
		sounds.currentBGM:stop()
		sounds.currentBGM = sounds["SFX"]["Victory"]
		sounds.currentBGM:play()
		zeroPlayerTurn()
		victory.timer = 2
		for i = 1, 4 do
			if not(battleenemies[i].id == "Void") then
				xpGained = xpGained + (battleenemies[i].xpbase * battleenemies[i].level)
				fazTokensGained = fazTokensGained + battleenemies[i].level 
			end
		end
		xpPool = xpGained
		fazTokens = fazTokens + fazTokensGained
		victorySFX = worldBattle:newRectangleCollider(love.graphics.getWidth() + 250, (love.graphics.getHeight() / 2), 40, 40, {collision_class = 'SFX'})
		victorySFX:setFixedRotation(true)
	end
	
	gameisover = checkIfGameOver()
	
	if gameisover == true then
		gameOversPlayer = gameOversPlayer + 1
		
		oldManStory = gameOversPlayer
	
		if oldManStory > 5 then
			oldManStory = 5
		end
		
		currentDialogIndex = 1
		currentMaxDialogIndex = #npcs["OldMan"]["Story"][oldManStory]
		
		gameMode = 3
		canChangeMusic = 1
	end
	
end
--REMEMBER TO ALWAYS DELETE THE FUCKING BODIES OFF THE TABLE!!!!!!!

--else
	--for a normal projectile, do damage and destroy itself
	--play the attack sound
--	attacks["Actor"][player.currentParty[i]][j].sound:stop()
--	attacks["Actor"][player.currentParty[i]][j].sound:play()
--	enteredEnemy[1].currentHealth = enteredEnemy[1].currentHealth - attacks["Actor"][player.currentParty[i]][j].damage
--	attacks["Actor"][player.currentParty[i]][j].body:destroy()
--	table.remove(attacks["Actor"][player.currentParty[i]], j)