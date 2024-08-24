--creating the player
player = {}
player.pflags = {}
player.currentzone = "Fazbear Hills" -- Dusting Fields
player.story = 1
player.currentParty = {"Freddy", "Bonnie", "Chica", "Foxy"}
player.currentRoster = {"Freddy", "Bonnie", "Chica", "Foxy"}

--player properties
player.x = 400
player.y = 200
player.collider = world:newBSGRectangleCollider(player.x, player.y, 35, 50, 14, {collision_class = "Player"})
player.collider:setFixedRotation(true)
player.speed = 170
player.direction = 3 --1 up 2 right 3 down 4 left
player.keySpeedControl = 0
player.animation = animations["Player"]["Idle"]["Down"]
--player flags/states
player.pflags.isMoving = 0

function playerUpdate(dt)
	--if the player exists
	if player.collider.body and gameMode == 1 then
		player.animation:update(dt)
		--update player position
		player.x = player.collider:getX()
		player.y = player.collider:getY()

		--if the player exists
	
		--Overworld Controls
		--Overworld player flags
		player.pflags.isMoving = 0
		--Amount of diretional keys being pressed at the same time
		player.keySpeedControl = 0
		
		--player velocity
		local vx = 0
		local vy = 0
	
		--Up direction, 1
		if love.keyboard.isDown('w') then
			vy = player.speed * -1
			player.animation = animations["Player"]["Running"]["Up"]
			player.pflags.isMoving = 1
			player.direction = 1
			player.keySpeedControl = player.keySpeedControl + 1
		end
		--Down direction, 3
		if love.keyboard.isDown('s') then
			vy = player.speed
			player.animation = animations["Player"]["Running"]["Down"]
			player.pflags.isMoving = 1
			player.direction = 3
			player.keySpeedControl = player.keySpeedControl + 1
		end
		--Left direction, 4
		if love.keyboard.isDown('a') then
			vx = player.speed * -1
			player.animation = animations["Player"]["Running"]["Left"]
			player.pflags.isMoving = 1
			player.direction = 4
			player.keySpeedControl = player.keySpeedControl + 1
		end
		--Right direction, 2
		if love.keyboard.isDown('d') then
			vx = player.speed
			player.animation = animations["Player"]["Running"]["Right"]
			player.pflags.isMoving = 1
			player.direction = 2
			player.keySpeedControl = player.keySpeedControl + 1
		end
	
		--Normalizing speed of corner directions
		if player.keySpeedControl > 1 then
			player.speed = 127.5
		else
			player.speed = 170
		end
	
		--Applying the velocity to the player
		player.collider:setLinearVelocity(vx, vy)
	
		--Controlling the player animations while moving in overworld
		if player.pflags.isMoving == 0 then
			if player.direction == 1 then
				player.animation = animations["Player"]["Idle"]["Up"]
			elseif player.direction == 2 then
				player.animation = animations["Player"]["Idle"]["Right"]
			elseif player.direction == 3 then
				player.animation = animations["Player"]["Idle"]["Down"]
			elseif player.direction == 4 then
				player.animation = animations["Player"]["Idle"]["Left"]
			end
		end
	end
end
--Overworld keys pressing
function playerKeypressed(key)

	--Toggle main menu
	if gameMode == 1 and key == "escape" then
		gameMode = 0.1
		canChangeMusic = 1
		--player party select
	elseif gameMode == 1.01 and key == "escape" then
		refreshPartyToSlots()
		gameMode = 1
	elseif	gameMode < 1 and key == "escape" then
		gameMode = 0
	end
	
	--check for NPC's and buildings
	if gameMode == 1 and key == "e" then
		--querying, will need to use later for sfx and battle gui!!
		--search for interactables
		local queryPosX, queryPosY = player.collider:getPosition()
		--up
		if player.direction == 1 then
			queryPosY = queryPosY - 20
		--right
		elseif player.direction == 2 then
			queryPosX = queryPosX + 20
		--down
		elseif player.direction == 3 then
			queryPosY = queryPosY + 20
		--left
		elseif player.direction == 4 then
			queryPosX = queryPosX - 20
		end
		local interactables = world:queryCircleArea(queryPosX, queryPosY, 20, 
		{'NPC', 'Shop', 'Collectable'})
		if #interactables > 0 then
			for i, obj in ipairs(interactables) do
				if obj.collision_class == "NPC" then
					playCutscene(obj.id, animations["Actor"][obj.id][npcs[obj.id]["Story"][npcs[obj.id]["Story"]["Progress"]]["Animations"][currentDialogIndex]], 
					sprites["Actor"][obj.id], npcs[obj.id]["Story"], npcs[obj.id]["Story"]["Progress"])
				end				
			end
		end
	end
	
	if gameMode == 1 and key == "f" then
		--remember to make a function that trigger a battle
		canChangeMusic = 1
		spawnBattle()
	end
	
	if gameMode == 2 and key == "escape" then
		canChangeMusic = 1
		gameMode = 1
	end
	
end

function drawPlayer()
	player.animation:draw(sprites["Player"], player.x, player.y, nil, 1, nil, 30, 30)
end
