Player = Object:extend()

north = love.graphics.newImage("img/north.png")
east = love.graphics.newImage("img/east.png")
south = love.graphics.newImage("img/south.png")
west = love.graphics.newImage("img/west.png")

function Player:new()
	self.image = love.graphics.newImage("img/player.png")
	self.x = 200
	self.y = 200
	self.height = 50
	self.width = 50
	self.speed = 200
	self.runSpeed = 400
	self.position = "entrance"
end

function Player:update(dt)
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

	if self.y < 100 then
		self.y = self.y + self.runSpeed * dt
	elseif self.y > 650 then
		self.y = self.y - self.runSpeed * dt
	elseif self.x < 100 then
		self.x = self.x + self.runSpeed * dt
	elseif self.x > 650 then
		self.x = self.x - self.runSpeed * dt
	end
	
function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

end
