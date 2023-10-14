local waveFunction = require "Tilemap.waveFunctionCollapse"

function initTilemapSystem()
	AvailableTileQuads = {}

	for x = 1, TilesetTexture:getWidth() * TilesetTexture:getHeight() / 256, 1 do
		AvailableTileQuads[x] = love.graphics.newQuad(((x - 1) % (TilesetTexture:getWidth() / 16)) * 16, math.floor((x - 1) / (TilesetTexture:getWidth() / 16)) * 16, 16, 16, TilesetTexture:getWidth(), TilesetTexture:getHeight())
	end

	TilePrototypes = {
		{
			type = 1,
			up = { 1, 2, 8 },
			right = { 1, 2, 8, 14 },
			down = { 1, 2, 8, 14, 15 },
			left = { 1, 2, 8 }
		},
		{
			type = 2,
			up = { 1, 2, 3, 4 },
			right = { 1, 2, 3, 4, 14 },
			down = { 1, 2, 3, 4, 14, 15 },
			left = { 1, 2, 3, 4 }
		},
		{
			type = 3,
			up = { 2, 3, 4 },
			right = { 2, 3, 4, 14 },
			down = { 2, 3, 4, 14, 15 },
			left = { 2, 3, 4 }
		},
		{
			type = 4,
			up = { 2, 3, 4, 17 },
			right = { 2, 3, 4, 14, 17 },
			down = { 2, 3, 4, 14, 15, 17 },
			left = { 2, 3, 4, 17 }
		},
		{
			type = 8,
			up = { 1 },
			right = { 1, 14 },
			down = { 1, 15, 14 },
			left = { 1 }
		},


		{
			type = 14,
			up = { 1, 2, 3, 4, 8, 17 },
			right = { 15, 16, 31 },
			down = { 27, 40, 31 },
			left = { 1, 2, 3, 4, 8, 17 }
		},
		{
			type = 15,
			up = { 1, 2, 3, 4, 8, 17 },
			right = { 16, 31 },
			down = { 28, 30, 41, 43 },
			left = { 1, 14 }
		},
		{
			type = 16,
			up = { 1, 2, 3, 4, 8, 17 },
			right = { 1, 2, 3, 4, 8, 17 },
			down = { 1 },
			left = { 1, 14, 16 }
		},
		{
			type = 17,
			up = { 4, 17 },
			right = { 4, 14, 17 },
			down = { 4, 14, 15, 17 },
			left = { 4, 17 }
		},


		{
			type = 27,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 28,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 29,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 30,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 31,
			up = { 1, 14 },
			right = { 1 },
			down = { 1 },
			left = { 1, 14, 15 }
		},
		{
			type = 32,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},


		{
			type = 40,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 41,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 42,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		},
		{
			type = 43,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
		}
	}
end

function generateTilemap(seed, width, height) 
	local tilemap = {}

	local generator = waveFunction.new(seed, width, height, TilePrototypes)

	tilemap = generator:collapse()

	math.randomseed(os.time()) -- reset random

	return tilemap
end

function drawTilemap(tilemap, scaleFactor)
	scaleFactor = scaleFactor or 1

	for x = 1, #tilemap, 1 do
		for y = 1, #tilemap[1], 1 do
			love.graphics.draw(
				TilesetTexture, 
				AvailableTileQuads[tilemap[x][y][1].type], 
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
end
