-- constants
local width = 1100
local height = 800
local friction = 0.9
local beta = 0.3
local repulsion = 10
local acceleration = 0.8

local speciesNum = 3
local particleNum = 600
local particle_radius = 3
local maxRadius = 30
local minRadius = 10

local forceMatrix = {}
local radiusMatrix = {}

local grid = {}

for i = 1, math.floor(width/maxRadius) do
	grid[i] = {}
	for j = 1, math.floor(height/maxRadius) do
		grid[i][j] = {}
	end
end

print("Generated grid")
--print(grid)

local abs = math.abs

local particle = {}
particle.__index = particle

function randomise()
	forceMatrix = {}
	radiusMatrix = {}
	for i = 1, speciesNum do
		forceMatrix[i] = {}
		radiusMatrix[i] = {}
		for j = 1, speciesNum do
			forceMatrix[i][j] = love.math.random() * 2 - 1
			radiusMatrix[i][j] = love.math.random() * (maxRadius - minRadius) + minRadius
		end
	end
end

function logTable(table)
	for i = 1, #table do
		for j = 1, #table[i] do
			io.write(tostring(table[i][j]) .. " ")
		end
		io.write("\n")
	end
end

function particle.new(species, x, y, gridX, gridY)
	local instance = {
		species = species,
		x = x,
		y = y,
		gridX = gridX,
		gridY = gridY,
	}
	setmetatable(instance, particle)
	return instance
end

function particle:calculateForce(distance, attraction)
	local r = distance/self.maxRadius
	if r >= 1 or r == 0 then
		return 0
	end
	if r < beta then
		return r/beta - 1
	end
	return attraction * (1 - abs(2 * r - 1 - beta)/(1 - beta))
end

function particle:update(dt)
	print "bleh"
end

--a = particle.new("A", 0, 0, 0, 0, 15)
--print(a:calculateForce(10, 5))

function love.load()
	love.window.setMode(width, height, {vsync = true})
end

function love.update(dt)
	--for i = 1, #particles do
	--	particles[i]:update(dt)
	--end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	--love.graphics.print("Hello World", 400, 300)
end

randomise()
print("Randomised matricies")
print("Force Matrix: ")
logTable(forceMatrix)
print("Radius Matrix: ")
logTable(radiusMatrix)