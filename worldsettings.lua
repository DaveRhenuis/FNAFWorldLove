--creating a new world with physics and gravity, see queries
world = windfield.newWorld(0, 0, false)
world:setQueryDebugDrawing(true)

worldBattle = windfield.newWorld(0, 0, false)
worldBattle:setQueryDebugDrawing(true)
	
--overworld collisions	(anything that needs to be ignored by other classes
--needs to be declared first!)
worldBattle:addCollisionClass('Button', {ignores = {'Button'}})
worldBattle:addCollisionClass('Enemy_attack', {ignores = {'Enemy_attack', 'Button'}})
worldBattle:addCollisionClass('Actor_attack', {ignores = {'Enemy_attack', 'Actor_attack', 'Button'}})
--worldBattle:addCollisionClass('Actor_block', {ignores = {'Actor_attack', 'Enemy_attack', 'Button'}})
--worldBattle:addCollisionClass('Enemy_block', {ignores = {'Enemy_attack', 'Actor_attack', 'Button'}})
worldBattle:addCollisionClass('Enemy', {ignores = {'Enemy_attack', 'Actor_attack', 'Button', 'Enemy'}})
worldBattle:addCollisionClass('Actor', {ignores = {'Actor_attack', 'Enemy_attack', 'Button', 'Actor', 'Enemy'}})
worldBattle:addCollisionClass('SFX', {ignores = {'Actor_attack', 'Enemy_attack', 'Button', 'Actor', 'Enemy', 'SFX'}})

world:addCollisionClass('Wall')
world:addCollisionClass('NPC')
world:addCollisionClass('Shop')
world:addCollisionClass('Collectable')
world:addCollisionClass('GlitchedObject')
world:addCollisionClass('Player', {ignores = {'NPC', 'Collectable'}})
world:addCollisionClass('PlayerGlitched', {ignores = {'NPC', 'Collectable', 'Wall'}})

--testing
--world:addCollisionClass('Danger')

--all wall collidables in overworld
walls = {}
	
function createWallObjects()
	if gameMap.layers["Walls"] then
		for i, obj in pairs(gameMap.layers["Walls"].objects) do
			local new_wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height, {collision_class = "Wall"})
			new_wall:setType('static')
			table.insert(walls, new_wall)
		end
	end
end

--drawables
--Well, pretty self explanatory
function terrainDrawBeforePlayer()
	gameMap:drawLayer(gameMap.layers["Grass Layer"])
	gameMap:drawLayer(gameMap.layers["Logs Layer"])
	gameMap:drawLayer(gameMap.layers["Trees Layer"])
	gameMap:drawLayer(gameMap.layers["Castle Layer"])
end

function terrainDrawAfterPlayer()
	gameMap:drawLayer(gameMap.layers["Axe Layer"])
	gameMap:drawLayer(gameMap.layers["Movebehind Layer"])
end