--MAKE ABILLITIES PROPERTIES TO INHERIT IN BATTLE
abilities = {}

--REMEMBER TO ALWAYS ADD THE SCREEN SHAKE AND DAMAGE INDICATOR

--red abilities
abilities["Pizza Wheel"] = {}
abilities["Pizza Wheel"].id = "Pizza Wheel"
abilities["Pizza Wheel"].atype = "Attack"
abilities["Pizza Wheel"].isAOE = true
abilities["Pizza Wheel"].requireTarget = false
abilities["Pizza Wheel"].hasMovement = true
abilities["Pizza Wheel"].hasSFX = true
abilities["Pizza Wheel"].red = 255/255
abilities["Pizza Wheel"].green = 50/255
abilities["Pizza Wheel"].blue = 63/255
abilities["Pizza Wheel"].alpha = 1.0
--this offset is for the buttons text
abilities["Pizza Wheel"].offsetX = love.graphics.getWidth() * 0.052
abilities["Pizza Wheel"].offsetY = love.graphics.getHeight() * 0.02
abilities["Pizza Wheel"].sfxanimation = animations["SFX"]["Star Trail"]
abilities["Pizza Wheel"].sfxname = "Star Trail"
abilities["Pizza Wheel"].sfxoffsetX = -120
abilities["Pizza Wheel"].sfxoffsetY = 20
--the base of the attack
--3, 5 pizzas + 10% of char level, each doing 1, 2 damage + 30% character damage
function pizzaWheel(name, actorIndex)
	for i = 1, math.random(3 + math.floor(actors[name].level / 10), 5 + math.floor(actors[name].level / 10)) do
		local randomY = math.random((love.graphics.getHeight() * 0.35), (love.graphics.getHeight() * 0.75))
		pizza = worldBattle:newRectangleCollider(-100, randomY, (love.graphics.getHeight() * 0.1), (love.graphics.getHeight() * 0.1), {collision_class = 'Actor_attack'})
		pizza.id = "pizza"
		pizza.atktype = "projectile"
		pizza.atkname = "Pizza Wheel"
		pizza.animation = animations["Attacks"]["Pizza Wheel"]
		pizza.depthY = randomY
		pizza.impulse = math.random(100, 200)
		--this works as the offset:
		pizza.width = (love.graphics.getHeight() * 0.1)
		pizza.height = (love.graphics.getHeight() * 0.1)
		--use something like this to see if you can target someone or not
		pizza.alreadyDamaged = {0, 0, 0, 0}
		pizza.damage = math.random(1, 2) + math.floor((battleactors[actorIndex].adamage) * 0.30)
		pizza.sound = sounds["SFX"]["Pizza Wheel"]
		table.insert(attacks["Actor"][name], pizza)
		shakeScreenFunction(0.85)
	end
end
--index of the current pizza index in the attacks from actors table
function pizzaWheelMovement(name, index)
	attacks["Actor"][name][index].body:applyLinearImpulse(attacks["Actor"][name][index].impulse, 0)
end
--enemyEnteredTable = the query table that have the enemy we entered, name = current actor name, index = index of the 
--current pizza index in the attacks from actors table
function pizzaWheelDamageScript(enemyEnteredTable, name, index)
	if #enemyEnteredTable > 0 then
		for h = 1, #enemyEnteredTable do
			local alreadyDamagedThisEnemy = false
			for k = 1, #attacks["Actor"][name][index].alreadyDamaged do
				if enemyEnteredTable[h].index == attacks["Actor"][name][index].alreadyDamaged[k] then
					alreadyDamagedThisEnemy = true
				end
			end
			--if we haven't damaged this enemy already then
			if alreadyDamagedThisEnemy == false and enemyEnteredTable[h].eflags.isDead == 0 then
				--damage the enemy
				--play the attack sound
				attacks["Actor"][name][index].sound:stop()
				attacks["Actor"][name][index].sound:play()
				enemyEnteredTable[h].currentHealth = enemyEnteredTable[h].currentHealth - attacks["Actor"][name][index].damage
				createDamageIndicator(attacks["Actor"][name][index].damage, enemyEnteredTable[h].body)
				createHitIndicator(enemyEnteredTable[h].body)
				shakeScreenFunction(0.1)
				hitOrangeOverlayFunction(0.2)
				checkIfIsDead(enemyEnteredTable[h])
				--put the index in the damaged enemies index
				for l = 1, #attacks["Actor"][name][index].alreadyDamaged do
					if attacks["Actor"][name][index].alreadyDamaged[l] == 0 then
						attacks["Actor"][name][index].alreadyDamaged[l] = enemyEnteredTable[h].index
						--on founding the first empty zero space, break the loop
						break
					end
				end
			end
		end
	end
end
abilities["Pizza Wheel"].script = pizzaWheel
abilities["Pizza Wheel"].movement = pizzaWheelMovement
abilities["Pizza Wheel"].damageScript = pizzaWheelDamageScript
abilities["Pizza Wheel"].abilityCost = 100

abilities["Bash Jam"] = {}
abilities["Bash Jam"].id = "Bash Jam"
abilities["Bash Jam"].atype = "Attack"
abilities["Bash Jam"].isAOE = true
abilities["Bash Jam"].requireTarget = false
abilities["Bash Jam"].red = 255/255
abilities["Bash Jam"].green = 50/255
abilities["Bash Jam"].blue = 63/255
abilities["Bash Jam"].alpha = 1.0
--this offset is for the buttons text
abilities["Bash Jam"].offsetX = love.graphics.getWidth() * 0.045
abilities["Bash Jam"].offsetY = love.graphics.getHeight() * 0.02
abilities["Bash Jam"].abilityCost = 100

abilities["Jumpscare"] = {}
abilities["Jumpscare"].id = "Jumpscare"
abilities["Jumpscare"].atype = "Attack"
abilities["Jumpscare"].isAOE = true
abilities["Jumpscare"].requireTarget = false
abilities["Jumpscare"].red = 255/255
abilities["Jumpscare"].green = 50/255
abilities["Jumpscare"].blue = 63/255
abilities["Jumpscare"].alpha = 1.0
--this offset is for the buttons text
abilities["Jumpscare"].offsetX = love.graphics.getWidth() * 0.05
abilities["Jumpscare"].offsetY = love.graphics.getHeight() * 0.02
abilities["Jumpscare"].abilityCost = 100

abilities["Hot Cheese"] = {}
abilities["Hot Cheese"].id = "Hot Cheese"
abilities["Hot Cheese"].atype = "Attack"
abilities["Hot Cheese"].isAOE = true
abilities["Hot Cheese"].requireTarget = false
abilities["Hot Cheese"].red = 255/255
abilities["Hot Cheese"].green = 50/255
abilities["Hot Cheese"].blue = 63/255
abilities["Hot Cheese"].alpha = 1.0
--this offset is for the buttons text
abilities["Hot Cheese"].offsetX = love.graphics.getWidth() * 0.05
abilities["Hot Cheese"].offsetY = love.graphics.getHeight() * 0.02
abilities["Hot Cheese"].abilityCost = 100

abilities["Mega Bite"] = {}
abilities["Mega Bite"].id = "Mega Bite"
abilities["Mega Bite"].atype = "Attack"
abilities["Mega Bite"].isAOE = false
abilities["Mega Bite"].requireTarget = true
abilities["Mega Bite"].red = 255/255
abilities["Mega Bite"].green = 50/255
abilities["Mega Bite"].blue = 63/255
abilities["Mega Bite"].alpha = 1.0
--this offset is for the buttons text
abilities["Mega Bite"].offsetX = love.graphics.getWidth() * 0.05
abilities["Mega Bite"].offsetY = love.graphics.getHeight() * 0.02
abilities["Mega Bite"].abilityCost = 100

--orange abilities
abilities["Mic Toss"] = {}
abilities["Mic Toss"].id = "Mic Toss"
abilities["Mic Toss"].atype = "Attack"
abilities["Mic Toss"].isAOE = false
abilities["Mic Toss"].requireTarget = true
abilities["Mic Toss"].red = 255/255
abilities["Mic Toss"].green = 184/255
abilities["Mic Toss"].blue =  78/255
abilities["Mic Toss"].alpha = 1.0
--this offset is for the buttons text
abilities["Mic Toss"].offsetX = love.graphics.getWidth() * 0.04
abilities["Mic Toss"].offsetY = love.graphics.getHeight() * 0.02
abilities["Mic Toss"].abilityCost = 100

abilities["Bite"] = {}
abilities["Bite"].id = "Bite"
abilities["Bite"].atype = "Attack"
abilities["Bite"].isAOE = false
abilities["Bite"].requireTarget = true
abilities["Bite"].red = 255/255
abilities["Bite"].green = 184/255
abilities["Bite"].blue = 78/255
abilities["Bite"].alpha = 1.0
--this offset is for the buttons text
abilities["Bite"].offsetX = love.graphics.getWidth() * 0.025
abilities["Bite"].offsetY = love.graphics.getHeight() * 0.02
abilities["Bite"].abilityCost = 100

abilities["Hook"] = {}
abilities["Hook"].id = "Hook"
abilities["Hook"].atype = "Attack"
abilities["Hook"].isAOE = false
abilities["Hook"].requireTarget = true
abilities["Hook"].red = 255/255
abilities["Hook"].green = 184/255
abilities["Hook"].blue = 78/255
abilities["Hook"].alpha = 1.0
--this offset is for the buttons text
abilities["Hook"].offsetX = love.graphics.getWidth() * 0.03
abilities["Hook"].offsetY = love.graphics.getHeight() * 0.02
abilities["Hook"].abilityCost = 100

--white abilities
abilities["Birthday"] = {}
abilities["Birthday"].id = "Birthday"
abilities["Birthday"].atype = "Buff"
abilities["Birthday"].isAOE = false
abilities["Birthday"].requireTarget = true
abilities["Birthday"].red = 1.0
abilities["Birthday"].green = 1.0
abilities["Birthday"].blue = 1.0
abilities["Birthday"].alpha = 1.0
--this offset is for the buttons text
abilities["Birthday"].offsetX = love.graphics.getWidth() * 0.04
abilities["Birthday"].offsetY = love.graphics.getHeight() * 0.02
abilities["Birthday"].abilityCost = 100

abilities["Solo"] = {}
abilities["Solo"].id = "Solo"
abilities["Solo"].atype = "Buff"
abilities["Solo"].isAOE = true
abilities["Solo"].requireTarget = false
abilities["Solo"].red = 1.0
abilities["Solo"].green = 1.0
abilities["Solo"].blue = 1.0
abilities["Solo"].alpha = 1.0
--this offset is for the buttons text
abilities["Solo"].offsetX = love.graphics.getWidth() * 0.022
abilities["Solo"].offsetY = love.graphics.getHeight() * 0.02
abilities["Solo"].abilityCost = 100

--black abilities
abilities["Unscrew"] = {}
abilities["Unscrew"].id = "Unscrew"
abilities["Unscrew"].atype = "Attack"
abilities["Unscrew"].isAOE = false
abilities["Unscrew"].requireTarget = true
abilities["Unscrew"].red = 0
abilities["Unscrew"].green = 0
abilities["Unscrew"].blue = 0
abilities["Unscrew"].alpha = 1.0
--this offset is for the buttons text
abilities["Unscrew"].offsetX = love.graphics.getWidth() * 0.042
abilities["Unscrew"].offsetY = love.graphics.getHeight() * 0.02
abilities["Unscrew"].abilityCost = 100

abilities["Glitch"] = {}
abilities["Glitch"].id = "Glitch"
abilities["Glitch"].atype = "Attack"
abilities["Glitch"].isAOE = false
abilities["Glitch"].requireTarget = true
abilities["Glitch"].red = 0
abilities["Glitch"].green = 0
abilities["Glitch"].blue = 0
abilities["Glitch"].alpha = 1.0
--this offset is for the buttons text
abilities["Glitch"].offsetX = love.graphics.getWidth() * 0.028
abilities["Glitch"].offsetY = love.graphics.getHeight() * 0.02
abilities["Glitch"].abilityCost = 100

--green abilities
abilities["Bad Pizza"] = {}
abilities["Bad Pizza"].id = "Bad Pizza"
abilities["Bad Pizza"].atype = "Attack"
abilities["Bad Pizza"].isAOE = true
abilities["Bad Pizza"].requireTarget = false
abilities["Bad Pizza"].red = 89/255
abilities["Bad Pizza"].green = 186/255
abilities["Bad Pizza"].blue = 78/255
abilities["Bad Pizza"].alpha = 1.0
--this offset is for the buttons text
abilities["Bad Pizza"].offsetX = love.graphics.getWidth() * 0.045
abilities["Bad Pizza"].offsetY = love.graphics.getHeight() * 0.02
abilities["Bad Pizza"].abilityCost = 100

--purple abilites
abilities["Sludge"] = {}
abilities["Sludge"].id = "Sludge"
abilities["Sludge"].atype = "Debuff"
abilities["Sludge"].isAOE = false
abilities["Sludge"].requireTarget = true
abilities["Sludge"].red = 180/255
abilities["Sludge"].green = 65/255
abilities["Sludge"].blue = 215/255
abilities["Sludge"].alpha = 1.0
--this offset is for the buttons text
abilities["Sludge"].offsetX = love.graphics.getWidth() * 0.03
abilities["Sludge"].offsetY = love.graphics.getHeight() * 0.02
abilities["Sludge"].abilityCost = 100

--pink abilities
abilities["Happy Jam"] = {}
abilities["Happy Jam"].id = "Happy Jam"
abilities["Happy Jam"].atype = "Heal"
abilities["Happy Jam"].isAOE = true
abilities["Happy Jam"].requireTarget = false
abilities["Happy Jam"].red = 255/255
abilities["Happy Jam"].green = 89/255
abilities["Happy Jam"].blue = 187/255
abilities["Happy Jam"].alpha = 1.0
--this offset is for the buttons text
abilities["Happy Jam"].offsetX = love.graphics.getWidth() * 0.055
abilities["Happy Jam"].offsetY = love.graphics.getHeight() * 0.02
abilities["Happy Jam"].abilityCost = 100

abilities["Cupcake"] = {}
abilities["Cupcake"].id = "Cupcake"
abilities["Cupcake"].atype = "Heal"
abilities["Cupcake"].isAOE = false
abilities["Cupcake"].requireTarget = true
abilities["Cupcake"].red = 255/255
abilities["Cupcake"].green = 89/255
abilities["Cupcake"].blue = 187/255
abilities["Cupcake"].alpha = 1.0
--this offset is for the buttons text
abilities["Cupcake"].offsetX = love.graphics.getWidth() * 0.04
abilities["Cupcake"].offsetY = love.graphics.getHeight() * 0.02
abilities["Cupcake"].abilityCost = 100

abilities["Party Favors"] = {}
abilities["Party Favors"].id = "Party Favors"
abilities["Party Favors"].atype = "Heal"
abilities["Party Favors"].isAOE = true
abilities["Party Favors"].requireTarget = false
abilities["Party Favors"].red = 255/255
abilities["Party Favors"].green = 89/255
abilities["Party Favors"].blue = 187/255
abilities["Party Favors"].alpha = 1.0
--this offset is for the buttons text
abilities["Party Favors"].offsetX = love.graphics.getWidth() * 0.055
abilities["Party Favors"].offsetY = love.graphics.getHeight() * 0.02
abilities["Party Favors"].abilityCost = 100

abilities["Regen Song"] = {}
abilities["Regen Song"].id = "Regen Song"
abilities["Regen Song"].atype = "Heal"
abilities["Regen Song"].isAOE = false
abilities["Regen Song"].requireTarget = true
abilities["Regen Song"].red = 255/255
abilities["Regen Song"].green = 89/255
abilities["Regen Song"].blue = 187/255
abilities["Regen Song"].alpha = 1.0
--this offset is for the buttons text
abilities["Regen Song"].offsetX = love.graphics.getWidth() * 0.055
abilities["Regen Song"].offsetY = love.graphics.getHeight() * 0.02
abilities["Regen Song"].abilityCost = 100

--yellow abilities

abilities["Mimic Ball"] = {}
abilities["Mimic Ball"].id = "Mimic Ball"
abilities["Mimic Ball"].atype = "Attack"
abilities["Mimic Ball"].isAOE = false
abilities["Mimic Ball"].requireTarget = true
abilities["Mimic Ball"].red = 255/255
abilities["Mimic Ball"].green = 252/255
abilities["Mimic Ball"].blue = 69/255
abilities["Mimic Ball"].alpha = 1.0
--this offset is for the buttons text
abilities["Mimic Ball"].offsetX = love.graphics.getWidth() * 0.05
abilities["Mimic Ball"].offsetY = love.graphics.getHeight() * 0.02
abilities["Mimic Ball"].abilityCost = 100

--VOID

abilities["Void"] = {}
abilities["Void"].id = "Void"
abilities["Void"].atype = "Void"
abilities["Void"].isAOE = false
abilities["Void"].requireTarget = false
abilities["Void"].red = 0
abilities["Void"].green = 0
abilities["Void"].blue = 0
abilities["Void"].alpha = 1.0
abilities["Void"].offsetX = love.graphics.getWidth() * 0.042
abilities["Void"].offsetY = love.graphics.getHeight() * 0.02
abilities["Void"].abilityCost = 0