local waveFunction = require "Tilemap.waveFunctionCollapse"

function initTilemapSystem()
	GroundTileQuads = {} -- ground tiles

	for x = 1, GroundTilesetTexture:getWidth() * GroundTilesetTexture:getHeight() / 256, 1 do
		GroundTileQuads[x] = love.graphics.newQuad(((x - 1) % (GroundTilesetTexture:getWidth() / 16)) * 16, math.floor((x - 1) / (GroundTilesetTexture:getWidth() / 16)) * 16, 16, 16, GroundTilesetTexture:getWidth(), GroundTilesetTexture:getHeight())
	end

	WaterTileQuads = {} -- water tiles

	for x = 1, WaterTilesetTexture:getWidth() * WaterTilesetTexture:getHeight() / 256, 1 do
		WaterTileQuads[x] = love.graphics.newQuad(((x - 1) % (WaterTilesetTexture:getWidth() / 16)) * 16, math.floor((x - 1) / (WaterTilesetTexture:getWidth() / 16)) * 16, 16, 16, WaterTilesetTexture:getWidth(), WaterTilesetTexture:getHeight())
	end

	GroundTilePrototypes = {
		{
			type = 1,
			up = { 1, 2 },
			right = { 1, 2 },
			down = { 1, 2 },
			left = { 1, 2 }
		},
		{
			type = 2,
			up = { 1, 2, 3, 4, 5 },
			right = { 1, 2, 3, 4, 5 },
			down = { 1, 2, 3, 4, 5 },
			left = { 1, 2, 3, 4, 5 }
		},
		{
			type = 3,
			up = { 2, 3, 4, 5 },
			right = { 2, 3, 4, 5 },
			down = { 2, 3, 4, 5 },
			left = { 2, 3, 4, 5 }
		},
		{
			type = 4,
			up = { 2, 3, 4, 5 },
			right = { 2, 3, 4, 5 },
			down = { 2, 3, 4, 5 },
			left = { 2, 3, 4, 5 }
		},
		{
			type = 5,
			up = { 2, 3, 4, 5, 7 },
			right = { 2, 3, 4, 5, 7 },
			down = { 2, 3, 4, 5, 7 },
			left = { 2, 3, 4, 5, 7 }
		},
		{
			type = 6,
			up = { 4, 5, 6, 7 },
			right = { 4, 5, 6, 7 },
			down = { 4, 5, 6, 7 },
			left = { 4, 5, 6, 7 }
		},
		{
			type = 7,
			up = { 1, 5, 6 },
			right = { 1, 5, 6 },
			down = { 1, 5, 6 },
			left = { 1, 5, 6 }
		}
	}
	
	WaterTilePrototypes = {
		{ -- river curves
			type = 1,
			up = { 7, 8, 24 },
			right = { 2, 22 },
			down = { 7, 12 },
			left = { 2, 8, 12, 24 }
		},
		{
			type = 2,
			up = { 7, 8, 24 },
			right = { 1, 7, 12, 24 },
			down = { 8, 12 },
			left = { 1, 22 }
		},
		{ -- next row
			type = 7,
			up = { 1, 12 },
			right = { 8, 22 },
			down = { 1, 2, 24 },
			left = { 2, 8, 12, 24 }
		},
		{
			type = 8,
			up = { 2, 12 },
			right = { 1, 7, 12, 24 },
			down = { 1, 2, 24 },
			left = { 7, 22 }
		},
		

		{ -- river lines
			type = 12,
			up = { 1, 2, 12 },
			down = { 7, 8, 12 },
			left = { 2, 8, 24 },
			right = { 1, 7, 24 }, 
		},
		{
			type = 22,
			up = { 7, 8, 24 },
			down = { 1, 2, 24 },
			left = { 1, 7, 22 },
			right = { 2, 8, 22 }, 
		},


		{
			type = 24,
			up = { 7, 8, 22, 24 },
			right = { 1, 7, 12, 24 },
			down = { 1, 2, 22, 24 },
			left = { 2, 8, 12, 24 }
		}
	}
end

function generateTilemap(seed, width, height) 
	local tilemap = {}

	local generator = waveFunction.new(seed, width, height, GroundTilePrototypes)

	tilemap[1] = generator:collapse()

	-- generator = waveFunction.new(seed, width, height, WaterTilePrototypes)

	-- tilemap[2] = generator:collapse()

	math.randomseed(os.time()) -- reset random

	return tilemap
end

function drawTilemap(tilemap, scaleFactor)
	scaleFactor = scaleFactor or 1

	for x = 1, #tilemap[1], 1 do
		for y = 1, #tilemap[1][1], 1 do
			love.graphics.draw(
				GroundTilesetTexture, 
				GroundTileQuads[tilemap[1][x][y][1].type], 
				(x - 1) * 16 * scaleFactor, 
				(y - 1) * 16 * scaleFactor, 
				0, 
				scaleFactor, 
				scaleFactor, 
				0, 
				0
			)
		end
	end

	--[[

	for x = 1, #tilemap[2], 1 do
		for y = 1, #tilemap[2][1], 1 do
			love.graphics.draw(
				WaterTilesetTexture, 
				WaterTileQuads[tilemap[2][x][y][1].type], 
				(x - 1) * 16 * scaleFactor * GraphicsGlobalScale, 
				(y - 1) * 16 * scaleFactor * GraphicsGlobalScale, 
				0, 
				scaleFactor * GraphicsGlobalScale, 
				scaleFactor * GraphicsGlobalScale, 
				0, 
				0
			)
		end
	end

	--]]
end
