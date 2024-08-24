--Sprites of the enemies of the game, make sure to load the file after the sprites_and_animations!
sprites["Enemy"] = {}
sprites["Enemy"]["Gearrat"] = love.graphics.newImage('sprites/Enemies_used/gearratSheet.png')
sprites["Enemy"]["Bouncepot"] = love.graphics.newImage('sprites/Enemies_used/bouncepotSheet.png')
sprites["Enemy"]["Chopnroll"] = love.graphics.newImage('sprites/Enemies_used/chopnrollSheet.png')
sprites["Enemy"]["Mechrab"] = love.graphics.newImage('sprites/Enemies_used/mechrabSheet.png')
sprites["Enemy"]["Totemole"] = love.graphics.newImage('sprites/Enemies_used/totemoleSheet.png')
sprites["Enemy"]["Void"] = love.graphics.newImage('sprites/Enemies_used/void.png')

grids["Enemy"] = {}
grids["Enemy"]["Gearrat"] =  anim8.newGrid(200, 200, sprites["Enemy"]["Gearrat"]:getWidth(),
sprites["Enemy"]["Gearrat"]:getHeight())
grids["Enemy"]["Bouncepot"] = anim8.newGrid(200, 200, sprites["Enemy"]["Bouncepot"]:getWidth(),
sprites["Enemy"]["Bouncepot"]:getHeight())
grids["Enemy"]["Chopnroll"] = anim8.newGrid(200, 300, sprites["Enemy"]["Chopnroll"]:getWidth(),
sprites["Enemy"]["Chopnroll"]:getHeight())
grids["Enemy"]["Mechrab"] = anim8.newGrid(200, 200, sprites["Enemy"]["Mechrab"]:getWidth(),
sprites["Enemy"]["Mechrab"]:getHeight())
grids["Enemy"]["Totemole"] = anim8.newGrid(200, 200, sprites["Enemy"]["Totemole"]:getWidth(),
sprites["Enemy"]["Totemole"]:getHeight())
grids["Enemy"]["Void"] = anim8.newGrid(250, 250, sprites["Enemy"]["Void"]:getWidth(),
sprites["Enemy"]["Void"]:getHeight())

--No enemy have attack animation, so everything is a Idle animation, when they attack, just pause the
--current frame, after attack end, continue animation (we could implement attack animations but
--idk how to pixel art nor blender animate, I'm just a programmer bro)
animations["Enemy"] = {}
animations["Enemy"]["Gearrat"] = anim8.newAnimation(grids["Enemy"]["Gearrat"]('1-10', 1), 0.05)
animations["Enemy"]["Bouncepot"] = anim8.newAnimation(grids["Enemy"]["Bouncepot"]('1-10', 1), 0.05)
animations["Enemy"]["Chopnroll"] = anim8.newAnimation(grids["Enemy"]["Chopnroll"]('1-10', 1), 0.05)
animations["Enemy"]["Mechrab"] = anim8.newAnimation(grids["Enemy"]["Mechrab"]('1-10', 1), 0.05)
animations["Enemy"]["Totemole"] = anim8.newAnimation(grids["Enemy"]["Totemole"]('1-10', 1), 0.05)
animations["Enemy"]["Void"] = anim8.newAnimation(grids["Enemy"]["Void"]('1-1', 1), 0.05)