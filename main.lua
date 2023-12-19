function love.load()
	-- Modules
	Object = require "classic"
	require "player"

        -- Window settings    
        love.window.setTitle("metalhead")
        love.window.setMode(1450, 800)
        font = love.graphics.newFont("img/Courier New.ttf", 20)

        -- Map Area     
        map = {
                x = 100,
                y = 100,
                height = 600,
                width = 600
        }

        -- Text/Menu area    
        square = {
                x = 750,
                y = 100,
                height = 600,
                width = 600
        }
 	
	-- PICKUP OBJs
	-- keyObj
	key = {
		x = map.x + 50,
		y = map.y + 245,
		height = 25,
		width = 25,
		acquired = false
	}

        -- phoneObj    
        phone = {
                x = map.x + 570,
                y = map.y + 5,
                height = 25,
		width = 25,
		acquired = false
        }

	--location:toilet
	toiletDoor = {
		x = map.x + 590,
		y = map.y + 475,
		height = 75,
		width = 10,
		unlocked = false
	}

	toilets = {
		x = map.x,
		y = map.y + 293,
		width = 200,
		height = 307,
	}

	stallwall = {
		x = map.x,
		y = map.y + 200,
		width = 200,
		height = 5
	}


       text = "Metalhead by Stafngrimr\n\nYou wake up in a bathroom, and can't remember how you got here. There's no one else around, and this place stinks. Your head hurts, you feel dazed and is that piss you can feel on your jeans?\nYou get up off the floor slowly and take a moment to gather yourself. Memories are slowly coming back. You're were at a metal gig with your mates. Someone bought a round of drinks and then... nothing.\n\nYou better get yourself out of here. Find your friends and find out what happened to you.\n\n"

        -- imagedump
	-- rooms
        entranceMap = love.graphics.newImage("img/rooms/entrance.png")
	toiletMap = love.graphics.newImage("img/rooms/toilet.png")
	cloakroomMap = love.graphics.newImage("img/rooms/cloakroom.png")
	barMap = love.graphics.newImage("img/rooms/bar.png")
	venueMap = love.graphics.newImage("img/rooms/venue.png")

	-- objects
	objToilets = love.graphics.newImage("img/objects/toilets.png")
	keyImage = love.graphics.newImage("img/objects/key.png")
	phoneImage = love.graphics.newImage("img/objects/phone.png")
	door_horizontal = love.graphics.newImage("img/objects/doorHorizontal.png")
	door_vertical = love.graphics.newImage("img/objects/doorVertical.png")

	player = Player()
end

function love.update(dt)
	player:update(dt)
	
	if player.position == "toilet" then
		player:resolveCollision(toilets.x, toilets.y, toilets.width, toilets.height)
		player:resolveCollision(stallwall.x, stallwall.y, stallwall.width, stallwall.height)
		if toiletDoor.unlocked == false then
			player:resolveCollision(toiletDoor.x, toiletDoor.y, toiletDoor.width, toiletDoor.height)
		end
	end

	-- Picking up of Obj(s)
	if player:collisionCheck(key.x, key.y, key.width, key.height)
	and player.position == "toilet"
	and key.acquired == false then
		text = text .."Aha, you've found the toilet door key! You can get out now\n\n"
		key.acquired = true
	elseif player:collisionCheck(phone.x, phone.y, phone.width, phone.height)
	and player.position == "venue"
	and phone.acquired == false then
		text = text .."Oh shit, it's my phone! Can't believe it hasn't been nicked. No signal though. I guess I'll try it back outside and see if I can reach anyone.\n\n"
		phone.acquired = true
	end

	--Toilet door unlock
	if player.position == "toilet" and key.acquired == true and player.interact == true then
		if player:interactionCheck(toiletDoor) == true then
			toiletDoor.unlocked = true
		end
	end

	-- Move from one room to another
	if player.position == "entrance" then
		if player:collisionCheck(map.x, map.y + 475, 1, 75) then
			player.position = "toilet"
			player.x = map.x + 540
			player.y = map.y + 487
		elseif player:collisionCheck(map.x + 599, map.y + 475, 1, 75) then
			player.position = "cloakroom"
			player.x = map.x + 10
			player.y = map.y + 487
		elseif player:collisionCheck(map.x + 261, map.y, 75, 1) then
			player.position = "bar"
			player.x = map.x + 273
			player.y = map.y + 540
		end
	elseif player.position == "toilet" then
		if player:collisionCheck(map.x + 599, map.y + 475, 1, 75) then
			player.position = "entrance"
			player.x = map.x + 10
			player.y = map.y + 487
		end
	elseif player.position == "cloakroom" then
		if player:collisionCheck(map.x, map.y + 475, 1, 75) then
			player.position = "entrance"
			player.x = map.x + 540
			player.y = map.y + 487
		end
	elseif player.position == "bar" then
		if player:collisionCheck(map.x, map.y + 261, 1, 75) then
			player.position = "venue"
			player.x = map.x + 540
			player.y = map.y + 273
		elseif player:collisionCheck(map.x + 261, map.y + 599, 75, 1) then
			player.position = "entrance"
			player.x = map.x + 273
			player.y = map.y + 10
		end
	elseif player.position == "venue" then
		if player:collisionCheck(map.x + 599, map.y + 261, 1, 75) then
			player.position = "bar"
			player.x = map.x + 10
			player.y = map.y + 273
		end
	end
end

function love.draw()
	-- drawing using position x y, width, height)
	
	-- Menustuff
	function menuText()
		love.graphics.setFont(font)
		love.graphics.setColor(1, 1, 0, 0.5)
		love.graphics.printf(text, square.x + 50, square.y + 50, 500)
	end

	-- Map
	if player.position == "entrance" then
		love.graphics.draw(entranceMap, map.x, map.y)
	elseif player.position == "toilet" then
		love.graphics.draw(toiletMap, map.x, map.y)
	elseif player.position == "cloakroom" then
		love.graphics.draw(cloakroomMap, map.x, map.y)
	elseif player.position == "bar" then
		love.graphics.draw(barMap, map.x, map.y)
	elseif player.position == "venue" then
		love.graphics.draw(venueMap, map.x, map.y)
	end

	-- Text/Menu Area
	love.graphics.rectangle("line", square.x, square.y, square.width, square.height)

	-- Key object
	if key.acquired == false and player.position == "toilet" then
		love.graphics.draw(keyImage, key.x, key.y)
	end

	-- Toilet door
	if toiletDoor.unlocked == false and player.position == "toilet" then
		love.graphics.draw(door_vertical, toiletDoor.x, toiletDoor.y)
	end

	-- Phone object
	if phone.acquired == false and player.position == "venue" then
		love.graphics.draw(phoneImage, phone.x, phone.y)
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
	-- Not going to use this anymore but keeping on here as it's useful.
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
