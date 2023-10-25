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
			up = { 1, 2, 3, 4, 5, 6, 7 },
			right = { 1, 2, 3, 4, 5, 6, 7 },
			down = { 1, 2, 3, 4, 5, 6, 7 },
			left = { 1, 2, 3, 4, 5, 6, 7 }
		},
		{
			type = 1,
			up = { 1, 2, 5, 6, 7 },
			right = { 1, 2, 5, 6, 7 },
			down = { 1, 2, 5, 6, 7 },
			left = { 1, 2, 5, 6, 7 }
		},
		{
			type = 2,
			up = { 1, 2, 3, 4, 5, 6 },
			right = { 1, 2, 3, 4, 5, 6 },
			down = { 1, 2, 3, 4, 5, 6 },
			left = { 1, 2, 3, 4, 5, 6 }
		},
		{
			type = 2,
			up = { 1, 2, 3, 4, 5, 6 },
			right = { 1, 2, 3, 4, 5, 6 },
			down = { 1, 2, 3, 4, 5, 6 },
			left = { 1, 2, 3, 4, 5, 6 }
		},
		{
			type = 3,
			up = { 1, 2, 3, 4 },
			right = { 1, 2, 3, 4 },
			down = { 1, 2, 3, 4 },
			left = { 1, 2, 3, 4 }
		},
		{
			type = 4,
			up = { 2, 3, 4 },
			right = { 2, 3, 4 },
			down = { 2, 3, 4 },
			left = { 2, 3, 4 }
		},
		{
			type = 5,
			up = { 1, 2, 3, 4, 5, 6 },
			right = { 1, 2, 3, 4, 5, 6 },
			down = { 1, 2, 3, 4, 5, 6 },
			left = { 1, 2, 3, 4, 5, 6 }
		},
		{
			type = 6,
			up = { 1, 2, 3, 4, 5, 6 },
			right = { 1, 2, 3, 4, 5, 6 },
			down = { 1, 2, 3, 4, 5, 6 },
			left = { 1, 2, 3, 4, 5, 6 }
		},
		{
			type = 7,
			up = { 1 },
			right = { 1 },
			down = { 1 },
			left = { 1 }
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

function tilemapToSpriteBatch(texture, quads, tilemap)
	local batch = love.graphics.newSpriteBatch(texture, #tilemap * #tilemap[1])

	for x = 1, #tilemap, 1 do
		for y = 1, #tilemap[1], 1 do
			batch:add(quads[tilemap[x][y][1].type], 16 * x - 16, 16 * y - 16)
		end
	end
	
	batch:flush()

	return batch
end

function generateTilemap(seed, width, height) 
	local tilemap = { }

	local generator = waveFunction.new(seed, width, height, GroundTilePrototypes)
	local groundTilemap = generator:collapse()

	tilemap[1] = tilemapToSpriteBatch(GroundTilesetTexture, GroundTileQuads, groundTilemap)

	math.randomseed(os.time()) -- reset random

	return tilemap
end

function drawTilemap(tilemapBatch)
	scaleFactor = scaleFactor or 1

	love.graphics.draw(tilemapBatch[1], 0, 0, 0, 1, 1, 0, 0)
end
