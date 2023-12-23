function love.load()
	-- Modules
	Object = require "classic"
	require "player"

        -- Window settings    
        love.window.setTitle("metalhead")
        love.window.setMode(1450, 800)
        font = love.graphics.newFont("img/Courier New.ttf", 20)
	gameOver = false
	gameIntro = true

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
		image = love.graphics.newImage("img/objects/key.png"),
		acquired = false
	}

        -- phoneObj    
        phone = {
                x = map.x + 570,
                y = map.y + 5,
                height = 25,
		width = 25,
		image = love.graphics.newImage("img/objects/phone.png"),
		acquired = false
        }

	--location:toilet
	toiletDoor = {
		x = map.x + 590,
		y = map.y + 475,
		height = 75,
		width = 10,
		unlocked = false,
		interact = false,
		intx = map.x + 560,
		inty = map.y + 470,
		intw = 30,
		inth = 85
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

	--location:entrance
	venueDoor = {
		x = map.x + 261,
		y = map.y,
		width = 75,
		height = 10,
		unlocked = false,
		interact = false,
		intx = map.x + 256,
		inty = map.y,
		intw = 85,
		inth = 40
	}

	merchTable = {
		x = map.x + 30,
		y = map.y + 50,
		width = 100,
		height = 200,
	}

	--location:cloakroom
	cloakTable = {
		x = map.x + 425,
		y = map.y + 400,
		width = 100,
		height = 200,
		interact = false,
		intx = map.x + 395,
		inty = map.y + 400,
		intw = 30,
		inth = 200
	}
	
	cloakTable2 = {
		x = map.x,
		y = map.y + 300,
		width = 600,
		height = 100
	}

	--location:bar
	bartop = {
		x = map.x + 450,
		y = map.y,
		width = 75,
		height = 300,
		interact = false,
		intx = map.x + 420,
		inty = map.y + 50,
		intw = 30,
		inth = 200
	}

	barbottom = {
		x = map.x + 450,
		y = map.y + 300,
		width = 75,
		height = 300,
		interact = false,
		intx = map.x + 420,
		inty = map.y + 350,
		intw = 30,
		inth = 200
	}

	tableTopLeft = {
		x = map.x + 100,
		y = map.y + 150,
		width = 75,
		height = 75
	}

	tableTopRight = {
		x = map.x + 300,
		y = map.y + 150,
		width = 75,
		height = 75
	}

	tableBottomLeft = {
		x = map.x + 100,
		y = map.y + 350,
		width = 75,
		height = 75
	}

	tableBottomRight = {
		x = map.x + 300,
		y = map.y + 350,
		width = 75,
		height = 75
	}

	--location:venue
	secretDoor = {
		x = map.x + 200,
		y = map.y,
		width = 75,
		height = 10,
		interact = false,
		intx = map.x + 180,
		inty = map.y + 10,
		intw = 90,
		inth = 30
	}
	
	--Peoples
	bouncer = {
		x = map.x + 213,
		y = map.y + 550,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/bouncer.png"),
		interact = false,
		intx = map.x + 193,
		inty = map.y + 520,
		intw = 90,
		inth = 30
	}

	merchguy = {
		x = map.x + 20,
		y = map.y + 300,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/merchguy.png"),
		interact = false,
		intx = map.x + 70,
		inty = map.y + 280,
		intw = 30,
		inth = 90
	}

	cloakroomlady = {
		x = map.x + 530,
		y = map.y + 475,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/cloakroomlady.png")
	}

	barkeeptop = {
		x = map.x + 530,
		y = map.y + 125,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/bartop.png")
	}

	barkeepbottom = {
		x = map.x + 530,
		y = map.y + 425,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/barbottom.png")
	}

	robed_bar = {
		x = map.x + 20,
		y = map.y + 530,
		width = 50,
		height = 50,
		interact = false,
		intx = map.x,
		inty = map.y + 500,
		intw = 90,
		inth = 30
	}

	--TODO: Add in all the gig goers!
	--TODO: Add loads of robed dudes in the bar when you come out of the venue! Creeepy...
	
	mate1 = {
		x = map.x + 250,
		y = map.y + 400,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/mate1.png")
	}

	mate2 = {
		x = map.x + 310,
		y = map.y + 410,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/mate2.png")
	}

	mate3 = {
		x = map.x + 370,
		y = map.y + 400,
		width = 50,
		height = 50,
		image = love.graphics.newImage("img/peeps/mate3.png")
	}

	mates = {
		interact = false,
		intx = map.x + 250,
		inty = map.y + 350,
		intw = 170,
		inth = 50
	}
	

       text = "Metalhead by Stafngrimr\n\nYou wake up in a bathroom, and can't remember how you got here. There's no one else around, and this place stinks. Your head hurts, you feel dazed and is that piss you can feel on your jeans?\nYou get up off the floor slowly and take a moment to gather yourself. Memories are slowly coming back. You were at a metal gig with your mates. Someone bought a round of drinks and then... nothing.\n\nYou better get yourself out of here. Find your friends and find out what happened to you.\n\n"

        -- imagedump
	-- rooms
        entranceMap = love.graphics.newImage("img/rooms/entrance.png")
	toiletMap = love.graphics.newImage("img/rooms/toilet.png")
	cloakroomMap = love.graphics.newImage("img/rooms/cloakroom.png")
	barMap = love.graphics.newImage("img/rooms/bar.png")
	bar2Map = love.graphics.newImage("img/rooms/bar2.png")
	venueMap = love.graphics.newImage("img/rooms/venue.png")

	introScreen = love.graphics.newImage("img/introleft.png")
	enterScreen = love.graphics.newImage("img/introright.png")

	-- common objects
	door_horizontal = love.graphics.newImage("img/objects/doorHorizontal.png")
	door_vertical = love.graphics.newImage("img/objects/doorVertical.png")

	-- characters
	robedNorth = love.graphics.newImage("img/peeps/robednorth.png")
	robedEast = love.graphics.newImage("img/peeps/robedeast.png")
	robedSouth = love.graphics.newImage("img/peeps/robedsouth.png")
	robedWest = love.graphics.newImage("img/peeps/robedwest.png")

	player = Player()
end

function love.update(dt)
	player:update(dt)
	
	-- objects/people collisions
	if player.position == "toilet" then
		player:resolveCollision(toilets.x, toilets.y, toilets.width, toilets.height)
		player:resolveCollision(stallwall.x, stallwall.y, stallwall.width, stallwall.height)
		if toiletDoor.unlocked == false then
			player:resolveCollision(toiletDoor.x, toiletDoor.y, toiletDoor.width, toiletDoor.height)
		end
	end

	if player.position == "entrance" then
		player:resolveCollision(bouncer.x, bouncer.y, bouncer.width, bouncer.height)
		player:resolveCollision(merchguy.x, merchguy.y, merchguy.width, merchguy.height)
		player:resolveCollision(merchTable.x, merchTable.y, merchTable.width, merchTable.height)
		if venueDoor.unlocked == false then
			player:resolveCollision(venueDoor.x, venueDoor.y, venueDoor.width, venueDoor.height)
		end
		if phone.acquired == true then
			player:resolveCollision(mate1.x, mate1.y, mate1.width, mate1.height)
			player:resolveCollision(mate2.x, mate2.y, mate2.width, mate2.height)
			player:resolveCollision(mate3.x, mate3.y, mate3.width, mate3.height)
		end
	end

	if player.position == "cloakroom" then
		player:resolveCollision(cloakTable.x, cloakTable.y, cloakTable.width, cloakTable.height)
		player:resolveCollision(cloakTable2.x, cloakTable2.y, cloakTable2.width, cloakTable2.height)
	end

	if player.position == "bar" then
		if phone.acquired == true then
			player:resolveCollision(map.x, map.y, 600, 225)
			player:resolveCollision(map.x, map.y + 350, 175, 250)
			player:resolveCollision(map.x, map.y + 470, 225, 130)
			player:resolveCollision(map.x, map.y + 543, 250, 57)
			player:resolveCollision(map.x + 300, map.y, 300, 425)
			player:resolveCollision(map.x + 319, map.y, 281, 489)
			player:resolveCollision(map.x + 344, map.y, 256, 600)
		else
			player:resolveCollision(bartop.x, bartop.y, bartop.width, bartop.height)
			player:resolveCollision(barbottom.x, barbottom.y, barbottom.width, barbottom.height)
			player:resolveCollision(robed_bar.x, robed_bar.y, robed_bar.width, robed_bar.height)
			player:resolveCollision(tableTopLeft.x, tableTopLeft.y, tableTopLeft.width, tableTopLeft.height)
			player:resolveCollision(tableTopRight.x, tableTopRight.y, tableTopRight.width, tableTopRight.height)
			player:resolveCollision(tableBottomLeft.x, tableBottomLeft.y, tableBottomLeft.width, tableBottomLeft.height)
			player:resolveCollision(tableBottomRight.x, tableBottomRight.y, tableBottomRight.width, tableBottomRight.height)
		end
	end

	if player.position == "venue" then
		player:resolveCollision(secretDoor.x, secretDoor.y, secretDoor.width, secretDoor.height)
	end

	-- picking up objects
	if player:collisionCheck(key.x, key.y, key.width, key.height)
	and player.position == "toilet"
	and key.acquired == false then
		text = text .."Aha, you've found the toilet door key!\n\n"
		key.acquired = true
	elseif player:collisionCheck(phone.x, phone.y, phone.width, phone.height)
	and player.position == "venue"
	and phone.acquired == false then
		text = text .."Oh shit, it's my phone! Can't believe it hasn't been nicked. No signal though. I guess I'll try it back outside and see if I can reach anyone.\n\n"
		phone.acquired = true
	end


	-- door unlocks
	if player.position == "toilet" and player.interact == true then
		if player:interactionCheck(toiletDoor) == true then
			if key.acquired == true then
				toiletDoor.unlocked = true
			else
				if toiletDoor.interact == false then
					text = text .."Hm, I don't have the key for this door.. yet..\n\n"
					toiletDoor.interact = true
				end
			end
		end
	end

	if player.position == "entrance" and player.interact == true then
		if player:interactionCheck(venueDoor) == true then
			if venueDoor.unlocked == false and venueDoor.interact == false then
				text = text .."Venue door is locked for some reason. Guess only other choice is to try the cloakroom\n\n"
				venueDoor.interact = true
			end
		end
	end

	-- chat to...
	if player.position == "entrance" and player.interact == true then
		if player:interactionCheck(bouncer) == true then
			if bouncer.interact == false then
				text = text .."Bouncer: ...\n\n"
				bouncer.interact = true
			end
		elseif player:interactionCheck(merchguy) == true then
			if merchguy.interact == false then
				text = text .."Merch Guy: You're that bloke from earlier. I told you to stay away from my table! Piss off!\n\n"
				merchguy.interact = true
			end
		elseif phone.acquired == true and player:interactionCheck(mates) == true then
			if mates.interact == false then
				text = text .."Egg - Alright mate. You're round is it?\n\nBarney - Where the hell have you been? We've been looking for you and now the band's on and we're missing it! What's with all the robed guys?\n\nDave Lombardo - Hello my good friend!\n\nPress Enter Key"
				mates.interact = true
			end
		end
	end

	if player.position == "cloakroom" and player.interact == true then
		if player:interactionCheck(cloakTable) == true then
			if cloakTable.interact == false then
				text = "Attendant: Hello. You back again? Last band's on in a minute, didn't you say they're your favourite?They closed the door to the venue because someone was kicking off. Should be open now though if you wanted to go in.\n\nShe hands you some items in exchange for the ticket stub you found.\n\nIt's your wallet! Cards are all still there thank fuck.. there's also a weird bright red ticket stub, but with no number on it. It's been ripped, so I guess it's been used?\n\nBet my friends are in the venue.\n\n"
				cloakTable.interact = true
			end
		end
	end

	if player.position == "bar" and player.interact == true then
		if player:interactionCheck(bartop) == true then
			if bartop.interact == false then
				text = text.."Barstaff - You look like shit. Cheeky shot to settle yourself?\n\nYou're given some whisky. You shoot it back and feel both better and worse in equal measure. Maybe no more of that..\n\n"
				bartop.interact = true
			end
		elseif player:interactionCheck(barbottom) == true then
			if barbottom.interact == false then
				text = text.."Barstaff - Alright mate. You waiting? Those robed guys wandering about are a bit odd eh? Still, bouncer's let em in, so I guess they're alright.\n\n"
				barbottom.interact = true
			end
		elseif player:interactionCheck(robed_bar) == true then
			if robed_bar.interact == false then
				text = text.."He's completely blanking me.. \n\n"
				robed_bar.interact = true
			end
		end
	end

	if player.position == "venue" and player.interact == true then
		if player:interactionCheck(secretDoor) == true then
			if secretDoor.interact == false then
				text = text.. "Locked. No idea where this leads anyway. Probably staff only.\n\n"
				secretDoor.interact = true
			end
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
			if player.firstCloakroom == true then
				text = "You enter the cloakroom and the sight of it triggers a memory. You reach into your pocket and pull out a ticket stub numbered 66. Don't think I brought a jacket with me.. I wonder what she has of mine?\n\n"
				venueDoor.unlocked = true
				player.firstCloakroom = false
			end
		elseif player:collisionCheck(map.x + 261, map.y, 75, 1) then
			player.position = "bar"
			player.x = map.x + 273
			player.y = map.y + 540
			if player.firstBar == true then
				text = "You can hear the loud music coming from the venue room to your left. I guess the band started. Still no sign of any of my friends. Might try the barstaff, see if they know anything.. Who's the weirdo in the corner?\n\n"
			end
		end
	elseif player.position == "toilet" then
		if player:collisionCheck(map.x + 599, map.y + 475, 1, 75) then
			player.position = "entrance"
			player.x = map.x + 10
			player.y = map.y + 487
			if player.firstEntrance == true then
				text = "You come out into the lobby. The bouncer that patted you down when you came in is there by the door, looking silently vigilant. Front door looks locked, I wonder what that's about?\n\n"
				player.firstEntrance = false
			end
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
			player.firstBar = false
			if player.firstVenue == true then
				text = "Yep, the band is on. That's loud as fuck and my head is still killing me. This sucks. I can't see anyone I recognise straight away, I should look around.\n\n"
				player.firstVenue = false
			end
		elseif player:collisionCheck(map.x + 261, map.y + 599, 75, 1) then
			player.position = "entrance"
			player.x = map.x + 273
			player.y = map.y + 10
			player.firstBar = false
			if phone.acquired == true then
				text = "Your mates! Finally!\n\n"
			end
		end
	elseif player.position == "venue" then
		if player:collisionCheck(map.x + 599, map.y + 261, 1, 75) then
			player.position = "bar"
			player.x = map.x + 10
			player.y = map.y + 273
			if phone.acquired == true then
				text = text .."Okay.. that's creepy.. I gotta get out of here quickly."
			end
		end
	end
end

function love.draw()
	-- drawing using position x y, width, height)
	
	-- Menustuff
	function menuText()
		love.graphics.setFont(font)
		love.graphics.setColor(1, 1, 0, 1)
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
		if phone.acquired == true then
			love.graphics.draw(bar2Map, map.x, map.y)
		else
			love.graphics.draw(barMap, map.x, map.y)
		end
	elseif player.position == "venue" then
		love.graphics.draw(venueMap, map.x, map.y)
	end

	-- Text/Menu Area
	love.graphics.rectangle("line", square.x, square.y, square.width, square.height)

	--toilet objects
	if player.position == "toilet" then
		if key.acquired == false then
			love.graphics.draw(key.image, key.x, key.y)
		end
		if toiletDoor.unlocked == false then
			love.graphics.draw(door_vertical, toiletDoor.x, toiletDoor.y)
		end
	end

	--entrance objects
	if player.position == "entrance" then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(bouncer.image, bouncer.x, bouncer.y)
		love.graphics.draw(merchguy.image, merchguy.x, merchguy.y)
		if player.firstCloakroom == true then
			love.graphics.draw(door_horizontal, venueDoor.x, venueDoor.y)
		end
		if phone.acquired == true then
			love.graphics.draw(mate1.image, mate1.x, mate1.y)
			love.graphics.draw(mate2.image, mate2.x, mate2.y)
			love.graphics.draw(mate3.image, mate3.x, mate3.y)
		end
	end

	--cloakroom objects
	if player.position == "cloakroom" then
		love.graphics.draw(cloakroomlady.image, cloakroomlady.x, cloakroomlady.y)
	end
	
	--bar objects
	if player.position == "bar" then
		love.graphics.draw(barkeeptop.image, barkeeptop.x, barkeeptop.y)
		love.graphics.draw(barkeepbottom.image, barkeepbottom.x, barkeepbottom.y)
		if player.firstBar == true then
			love.graphics.draw(robedNorth, robed_bar.x, robed_bar.y)
		end
	end

	--venue objects
	if player.position == "venue" then
		love.graphics.draw(door_horizontal, secretDoor.x, secretDoor.y)
		if phone.acquired == false then
			love.graphics.draw(phone.image, phone.x, phone.y)
		end
	end

	menuText()
	love.graphics.setColor(1, 1, 1)

	-- Player
	player:draw()

	if gameIntro == true then
		love.graphics.draw(introScreen, map.x, map.y)
		love.graphics.draw(enterScreen, square.x, square.y)
	elseif gameOver == true then
		text = "GAME OVER.\n\nHope you enjoyed the game!\n\nPlease press ESC to exit."
	end
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
