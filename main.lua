function love.load()
	-- Window settings
	love.window.setTitle("Castle Stafngrimr")
	love.window.setMode(1450, 800)

	-- Player starter ettings
	square = {}
	square.x = 200
	square.y = 200
	square.height = 50
	square.width = 50

	-- Map Area
	map = {}
	map.x = 100
	map.y = 100
	map.height = 600
	map.width = 600

	-- imagedump
	exit = love.graphics.newImage("img/exit.png")
	north = love.graphics.newImage("img/north.png")
	west = love.graphics.newImage("img/west.png")
	east = love.graphics.newImage("img/east.png")
	south = love.graphics.newImage("img/south.png")
	playerImage = north
end

function love.update()
	if love.keyboard.isDown("w") then
		if love.keyboard.isDown("lshift") then
			square.y = square.y - 4
		else
			square.y = square.y - 2
		end
		playerImage = north
	elseif love.keyboard.isDown("s") then
		if love.keyboard.isDown("lshift") then
			square.y = square.y + 4
		else
			square.y = square.y + 2
		end
		playerImage = south
	elseif love.keyboard.isDown("a") then
		if love.keyboard.isDown("lshift") then
			square.x = square.x - 4
		else
			square.x = square.x - 2
		end
		playerImage = west
	elseif love.keyboard.isDown("d") then
		if love.keyboard.isDown("lshift") then
			square.x = square.x + 4
		else
			square.x = square.x + 2
		end
		playerImage = east
	end

	if square.y < 100 then
		square.y = square.y + 5
	elseif square.y > 650 then
		square.y = square.y - 5
	elseif square.x < 100 then
		square.x = square.x + 5
	elseif square.x > 650 then
		square.x = square.x - 5
	end
end

function love.draw()
	-- drawing using position x y, width, height)
	
	-- Map
	love.graphics.rectangle("line", map.x, map.y, map.width, map.height)

	-- Player
	love.graphics.draw(playerImage, square.x, square.y)

	-- Exit
	love.graphics.draw(exit, 1325, 100) -- Can't just put filename here
end

function love.focus(f)
	if not f then
		print("LOST FOCUS")
	else
		print("GAINED FOCUS")
	end
end

function love.mousepressed(x, y, button)
	if button == 1 and x < 1300 and x > 1275 and y < 125 and y > 100 then
		print("Quit by CROSS")
		love.event.quit()
	end
end

function love.keypressed(k)
	if k == "escape" then
		print("Quit by ESC")
		love.event.quit()
	end
end


function love.quit()
	print("Thanks for playing! Come back soon!")
end
