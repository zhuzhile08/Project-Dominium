require "utility"

local waveFunction = { }
waveFunction.__index = waveFunction

function waveFunction.new(seed, width, height, prototypes) 
	local self = setmetatable({}, waveFunction)

	self.seed = seed
	self.width = width
	self.height = height
	self.output = { }
	self.collapsed = false

	for x = 1, width, 1 do
		self.output[x] = { }

		for y = 1, height, 1 do
			self.output[x][y] = prototypes
		end
	end

	return self
end

function waveFunction:getLowestEntropyPos()
	local lowEntropies = { }

	local i = 1;

	for x = 1, #self.output, 1 do -- push all prototypes into a table with a pair of entropy and index
		for y = 1, #self.output[1], 1 do 
			if #self.output[x][y] ~= 1 then 
				table.insert(lowEntropies, { #self.output[x][y], ((y - 1) * #self.output + x) })
			end
			i = i + 1
		end
	end

	table.sort(lowEntropies, function (a, b) -- sort the table by entropy
		return a[1] < b[1]
	end)

	if #lowEntropies <= 1 then
		self.collapsed = true
	end

	local highest = 1

	while lowEntropies[1][1] == lowEntropies[highest][1] and highest < #lowEntropies do -- then get the upper bounds of the random number
		highest = highest + 1
	end

	return lowEntropies[math.random(highest)][2] -- pick a random one from the tiles with smallest entropy and return it
end

function waveFunction:collapseAndPropagate(position)
	local posX = (position - 1) % self.width + 1
	local posY = math.floor((position - 1) / self.width) + 1

	self.output[posX][posY] = { self.output[posX][posY][math.random(#self.output[posX][posY])] } -- pick a random tile from the prototypes

	local function propagate(originDirection, target) -- propagate the consequences to direct neighbors of a tile
		if #target > 1 then
			local resultTable = { }

			for _, t in pairs(originDirection) do
				for _, v in pairs(target) do
					if v.type == t then
						table.insert(resultTable, v)
					end
				end
			end

			return resultTable
		end

		return target
	end

	local function propagateFromPosition(x, y)
		if y > 1 then 
			self.output[x][y - 1] = 
			propagate(self.output[x][y][1].up, self.output[x][y - 1]) 
		end
		if x < #self.output then 
			self.output[x + 1][y] = 
			propagate(self.output[x][y][1].right, self.output[x + 1][y]) 
		end
		if y < #self.output then 
			self.output[x][y + 1] = 
			propagate(self.output[x][y][1].down, self.output[x][y + 1]) 
		end
		if x > 1 then 
			self.output[x - 1][y] = 
			propagate(self.output[x][y][1].left, self.output[x - 1][y]) 
		end
	end

	propagateFromPosition(posX, posY)
end

function waveFunction:collapse()
	math.randomseed(self.seed)

	local i = 1

	while not self.collapsed do
		self:collapseAndPropagate(self:getLowestEntropyPos())
		i = i + 1
	end

	return self.output
end

return waveFunction
