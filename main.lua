function love.load() --Everything initialization related ====================
	math.randomseed(os.time())

	--animations library
	anim8 = require 'libraries/anim8-master/anim8'
	--tiled map library
	sti = require 'libraries/simple_tiled_implementation/sti'
	--camera library
	cameraFile = require 'libraries/hump/camera'
	--physics library
	windfield = require 'libraries/windfield'
	--GUI library
	slab = require 'libraries/Slab-master'
	
	--initializing GUI
	slab.Initialize()
	--Gamemodes: 0-Main menu, 0.1-Main Menu Options 1-Overworld
	gameMode = 0
	--creating the camera
	camera = cameraFile()
	--creating the gamemap
	gameMap = sti('maps/gameMap.lua')
	
	--fix pixel blur
	love.graphics.setDefaultFilter("linear", "linear", 1) -- nearest

	--all my scripts for everything:
	require('worldsettings')
	require('sprites_and_animations')
	require('sprites_and_animations_enemies')
	require('actors')
	require('player')
	require('fixcamlimits')
	require('sounds')
	require('gui')
	require('worlddj')
	require('npcs')
	require('eventhandler')
	require('abilities_enemies')
	require('enemies')
	require('abilities')
	require('battle')
	
	love.mouse.setVisible(false)
	
	createWallObjects()
	
	--testing, remember to remove
	--dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class = 'Danger'})
	--dangerZone:setType('static')
	
end

function love.update(dt) --Everything "each frame" process related ==========

	--update windows
	slab.Update(dt)
	
	--update songs
	worlddjUpdate(dt)
	
	--gameMode for the main menu = 0, anything from the menu < 0
	mainMenuGUI(dt)
	hudOverworld(dt)
	cutscenesGUI(dt)
	
	eventHandler(dt)
	
	--gameMode for the Overworld = 1
	if gameMode == 1  then
		--update world
		world:update(dt)
		playerUpdate(dt)
		npcsUpdate(dt)
		camera:lookAt(player.x, player.y)
		
		--map borders limiter
		fixCam()
	end
	
	if gameMode == 2 then
		camera:lookAt(camLookingRNX, camLookingRNY)
		worldBattle:update(dt)
		battleUpdate(dt)
	end
	
end

function love.draw() --Everything draw related ==============================
	
	--overworld
	if gameMode == 1 then
		camera:attach()
			terrainDrawBeforePlayer()
			--if the player exists
			if player.collider.body then
				npcsDraw()
				drawPlayer()
			end
			terrainDrawAfterPlayer()
			--this shows the hitboxes
			--world:draw()
		camera:detach()
		--player current zone
		love.graphics.setFont(LcdSolid["017"])
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf("\"" .. player.currentzone .. "\"", (love.graphics.getWidth() * 0.02), (love.graphics.getHeight() * 0.02), 
		love.graphics.getWidth(), "left")
		love.graphics.printf("Faz Tokens: " .. fazTokens, (love.graphics.getWidth() * 0.70), love.graphics.getHeight() * 0.95, 
		love.graphics.getWidth() * 0.25, "right")
	end
	
	--party edit
	if gameMode == 1.01 then
		love.graphics.draw(sprites["Background"][player.currentzone], 0, 0, 0, scale["Background"]["X"], 
		scale["Background"]["Y"])
	end
	
	--cutscenes
	if gameMode == 1.1 or gameMode == 3 then
		cutscenesGUIdrawables()
	end
	
	--titlescreen
	if gameMode == 0 then
		love.graphics.draw(sprites["Titlescreen"]["Background"], 0, 0, 0, scale["Background"]["X"], 
		scale["Background"]["Y"])
		animations["Fnaftitle"]:draw(sprites["Titlescreen"]["Fnaftitle"], ((love.graphics.getWidth()/11)), 
		0, 0, scale["Background"]["X"], scale["Background"]["Y"])
		love.graphics.draw(sprites["Titlescreen"]["Animatronics"], 0, (love.graphics.getHeight()/7), 0,
		scale["Background"]["X"], scale["Background"]["Y"])
	end
	
	--main menu options
	if gameMode == 0.1 then
		love.graphics.draw(sprites["Background"][player.currentzone], 0, 0, 0, scale["Background"]["X"], 
		scale["Background"]["Y"])
	end
	
	if gameMode == 2 then
		camera:attach()
		--to make the ground shake, check if there is any damaging activated
			battleDraw()
			battleDrawOverhud()
			--this shows the hitbox
		--worldBattle:draw()
		camera:detach()
	end
	
	--put hud here
	slab.Draw()
	
	--party edit (only here because I need things to be drawn over the hud)
	if gameMode == 1.01 then
		partyselectGUIdrawable()
	end
	
	love.graphics.draw(sprites["SFX"]["Cursor"], love.mouse.getX(), love.mouse.getY(), 0, 0.75, 0.75)
	
end
function love.keypressed(key)
	playerKeypressed(key)
	if gameMode == 1.1 or gameMode == 3 then
		cutsceneKeypressed(key)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if gameMode == 2 then
		battleMousepressed(x, y, button, istouch, presses)
	end
end	

--[[TODO LIST

 ***DONT FORGET TO SIZE ALL SPRITES TO SCREEN SIZE%
1-Create a menu / just missing most of menus, but should be able to create all menus if wanted
2-Create a combat 
3-Create a team editor / done but missing 1 window with a "Selected right clicked" character, party stats and char stats
and abillities

4-Create cutscenes -- DONE! first feature mostly done, just need to tune story and npcs locations according to story
5-Create interactables/items -- 2/3 just need to put any new type of interactable in the types of objects in the world
6-Create shop -- missing but should be easy to do
7-Create gamemode -- 2/5 menus and overworld mostly done, missing boss/cutscene battle gamemode,
minigame gamemode (new characters should be unlocked through minigames!)

8-A map -- naaah, I don't think it's necessary

8.1- ZONE WARP (should be easy)
8.2- On zone change, change background and music
8.3- Add zone animations, like snow and sun

IMPORTANT: CREATE DIFFERENT MAPS TO DIFFERENT ZONES TO PREVENT GAME LAG ISSUES!!!

**REMEMBER TO ADD BACKGROUND CHANGE/MUSIC CHANGE/SFX PLAY FOR CUTSCENES ACCORDING TO CUTSCENE PROGRESS --absolutely doable
**REMEMBER TO ADD ANIMATED BACKGROUND TOO -- doable as well

9.1-You can equip chips and bytes on CHARACTERS, not as a global buff, wich can be purchased in shop or by finding secrets. 

11-Unlock mangle by buying animatronics parts and giving it to Mendo to re-assemble mangle
11.1-Unlock toy bonnie by getting max highscores in guitar-hero minigame, then he will challange you like tom morello
11.2-Unlock toy chica by finding her cupcakes around the world (1 each zone)
11.3-Unlock toy freddy by throwing X amount of pizzas
11.4-Unlock the puppet by finishing the game on normal
11.5-Unlock golden freddy by finishing the game on hard
11.6-Unlock spring bonnie by defeating every animatronic of the overworld
11.7-Unlock springtrap by finishing the game on nuzlocke
11.8-Unlock fredbear by getting all of his secrets (maybe getting all the above? 100% the game?)

NEW TODO LIST:

1-Create all the game attacks, but actually balanced and better.
2-Create more enemies.
3-All of the previous todo list.
4-Easter eggs
5-New characters!
6-Characters from the books! Pit Bonnie, Eleanor, Fetch, Stitchwraith, Faz-Goo, Ella, Ralpho (Bunny Call), Plushtrap Chaser (I don't have the ability to model/animate tho)
7-Really cool new abilities
8-Make the enemies move when attack

]]--