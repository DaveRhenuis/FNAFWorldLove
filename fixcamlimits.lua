function fixCam()
	--fixing camera limits ===============================
	local screen_width = love.graphics.getWidth()
	local screen_height = love.graphics.getHeight()
	local mapWidth = gameMap.width * gameMap.tilewidth
	local mapHeight = gameMap.height * gameMap.tileheight
		
	-- left border
	if camera.x < screen_width/2 then
		camera.x = screen_width/2
	end
	-- top border
	if camera.y < screen_height/2 then
		camera.y = screen_height/2
	end

	-- right border
	if camera.x > (mapWidth - screen_width/2) then
		camera.x = (mapWidth - screen_width/2)
	end
	-- bottom border
	if camera.y > (mapHeight - screen_height/2) then
		camera.y = (mapHeight - screen_height/2)
	end
end