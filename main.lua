function love.load()
	-- Modules
	Object = require "classic"
	require "player"

	player = Player()

        -- Window settings    
        love.window.setTitle("Metalhead by Stafngrimr")
        love.window.setMode(1450, 800)
        font = love.graphics.newFont("img/Courier New.ttf", 20)

        -- Map Area     
        map = {
                x = 100,
                y = 100,
                height = 600,
                width = 600
        }

        -- PickupObj    
        pickup = {
                x = 400,
                y = 500,
                diam = 25,
		acquired = false
        }

        -- Text/Menu area    
        square = {
                x = 750,
                y = 100,
                height = 600,
                width = 600
        }

        text = "This is where the menu text is going to go. We're going to leave this in right now as some kind of placeholder, but we'll change it up, with the pick up of an object. That's what's next. Pickup.. \n\nAnd roll\n\n"

        -- imagedump    
        entranceMap = love.graphics.newImage("img/entrance-bg.png")
	toiletMap = love.graphics.newImage("img/toilet-bg.png")
end

function collisionCheck(firstx, firsty, firstw, firsth, secondx, secondy, secondw, secondh)
	local obj1_left = firstx
	local obj1_right = firstx + firstw
	local obj1_top = firsty local obj1_bottom = firsty + firsth

	local obj2_left = secondx
	local obj2_right = secondx + secondw
	local obj2_top = secondy
	local obj2_bottom = secondy + secondh

	return obj1_right > obj2_left
		and obj1_left < obj2_right
		and obj1_bottom > obj2_top
		and obj1_top < obj2_bottom
end

function love.update(dt)
	player:update(dt)
	
	-- Interact with Pickup object
	if collisionCheck(player.x, player.y, player.width, player.height, pickup.x, pickup.y, 25, 25)
	and pickup.acquired == false then
		text = text .."You touched the goddamn line! Now I wonder if we can change it based on you not touching the thing.."
		pickup.acquired = true
	end

	-- Move from one room to another
	if player.position == "entrance" then
		if collisionCheck(player.x, player.y, player.width, player.height, 100, 575, 1, 75) then
			player.position = "toilet"
			player.x = 600
			player.y = 595
		end
	elseif player.position == "toilet" then
		if collisionCheck(player.x, player.y, player.width, player.height, 699, 575, 1, 75) then
			player.position = "entrance"
			player.x = 200
			player.y = 595
		end
	end
end

function love.draw()
	-- drawing using position x y, width, height)
	
	-- Menustuff
	function menuText()
		love.graphics.setFont(font)
		love.graphics.setColor(1, 0, 0, 0.5)
		love.graphics.printf(text, 800, 150, 500)
	end

	-- Map
	if player.position == "entrance" then
		love.graphics.draw(entranceMap, map.x, map.y)
	elseif player.position == "toilet" then
		love.graphics.draw(toiletMap, map.x, map.y)
	end

	-- Text/Menu Area
	love.graphics.rectangle("line", square.x, square.y, square.width, square.height)

	-- Pickupobject
	if pickup.acquired == false then
		love.graphics.setColor(1, 1, 0, 1)
		love.graphics.circle("fill", pickup.x, pickup.y, pickup.diam)
	end

	menuText()
	love.graphics.setColor(1, 1, 1)

	-- Player
	player:draw()
end

function love.focus(f)
	if not f then
		print("LOST FOCUS")
	else
		print("GAINED FOCUS")
	end
end

function love.mousepressed(x, y, button)
--	if button == 1 and x > 1400 and x < 1425 and y > 25 and y < 50 then
--		print("Quit by CROSS")
--		love.event.quit()
--	end
end

function love.keypressed(k)
	if k == "escape" then
		love.event.quit()
	end
end


function love.quit()
	print("Thanks for playing! Come back soon!")
end
