Player = Object:extend()

north = love.graphics.newImage("img/north.png")
east = love.graphics.newImage("img/east.png")
south = love.graphics.newImage("img/south.png")
west = love.graphics.newImage("img/west.png")

function Player:new()
	self.image = love.graphics.newImage("img/player.png")
	self.x = map.x + 400
	self.y = map.y + 400
	self.height = 50
	self.width = 50
	self.speed = 200
	self.runSpeed = 400
	self.position = "toilet"
	self.interact = false
	self.firstEntrance = true
	self.firstCloakroom = true
	self.firstBar = true
	self.firstVenue = true

	self.last = {
		x = self.x,
		y = self.y
	}
end

function Player:update(dt)
	-- collision updates
	self.last.x = self.x
	self.last.y = self.y

	-- Player movement
	if love.keyboard.isDown("w") then
		if love.keyboard.isDown("lshift") then
			self.y = self.y - self.runSpeed * dt
		else
			self.y = self.y - self.speed * dt
		end
		self.image = north
	elseif love.keyboard.isDown("d") then
		if love.keyboard.isDown("lshift") then
			self.x = self.x + self.runSpeed * dt
		else
			self.x = self.x + self.speed * dt
		end
		self.image = east
	elseif love.keyboard.isDown("s") then
		if love.keyboard.isDown("lshift") then
			self.y = self.y + self.runSpeed * dt
		else
			self.y = self.y + self.speed * dt
		end
		self.image = south
	elseif love.keyboard.isDown("a") then
		if love.keyboard.isDown("lshift") then
			self.x = self.x - self.runSpeed * dt
		else
			self.x = self.x - self.speed * dt
		end
		self.image = west
	else
		self.image = love.graphics.newImage("img/player.png")
	end

	-- game statuses
	if gameIntro == true then
		if love.keyboard.isDown("return") then
			gameIntro = false
		end
	elseif gameOver == false and mates.interact == true then
		if love.keyboard.isDown("return") then
			gameOver = true
		end
	end

	-- Player interaction
	if love.keyboard.isDown("space") then
		self.interact = true
	else
		self.interact = false
	end
		
	-- Player restricted movement within map
	if self.y < map.y then
		self.y = self.y + self.runSpeed * dt
	elseif self.y > (map.y + map.height) - self.height then
		self.y = self.y - self.runSpeed * dt
	elseif self.x < map.x then
		self.x = self.x + self.runSpeed * dt
	elseif self.x > (map.x + map.width) - self.width then
		self.x = self.x - self.runSpeed * dt
	end
end

-- Player collision checking
function Player:collisionCheck(objx, objy, objw, objh)
	local player_left = self.x
	local player_right = self.x + self.width
	local player_top = self.y
	local player_bottom = self.y + self.height
	local obj_left = objx
	local obj_right = objx + objw
	local obj_top = objy
	local obj_bottom = objy + objh

	return player_left < obj_right
	and player_right > obj_left
	and player_top < obj_bottom
	and player_bottom > obj_top
end

--collisionResolution
function Player:resolveCollision(objx, objy, objw, objh)
	if self:collisionCheck(objx, objy, objw, objh) then
		self.x = self.last.x
		self.y = self.last.y
	end
end

--Player interaction
function Player:interactionCheck(obj)
	local px = self.x + (self.width / 2)
	local py = self.y + (self.height / 2)

	local objleft = obj.intx
	local objright = obj.intx + obj.intw
	local objtop = obj.inty
	local objbottom = obj.inty + obj.inth

	if px >= objleft and px <= objright and py >= objtop and py <= objbottom then
		return true
	else
		return false
	end
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end
