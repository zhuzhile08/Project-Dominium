function initTilemapSystem()
	AvailableTiles = {1, 1, 1, 1, 2, 2, 3}
	
	AvailableTileQuads = {}

	for x = 0, TilesetTexture:getWidth() * TilesetTexture:getHeight() / 16 - 1, 1 do
		AvailableTileQuads[x + 1] = love.graphics.newQuad(math.floor(x%6) * 16, math.floor(x/6) * 16, 16, 16, TilesetTexture:getWidth(), TilesetTexture:getHeight());
	end
end

function generateTilemap(seed, width, height) 
	local tilemap = {}

	math.randomseed(seed)

	for x = 1, width, 1 do
		tilemap[x] = { }

		for y = 1, height, 1 do
			tilemap[x][y] = AvailableTiles[math.random(1, #AvailableTiles)]
		end
	end

	math.randomseed(os.time()) -- reset random

	return tilemap
end

function drawTilemap(tilemap, scaleFactor)
	scaleFactor = scaleFactor or 1

	for x = 0, #tilemap - 1, 1 do
		for y = 0, #tilemap[1] - 1, 1 do
			love.graphics.draw(
				TilesetTexture, 
				AvailableTileQuads[tilemap[x + 1][y + 1]], 
				x * 16 * scaleFactor * GraphicsGlobalScale, 
				y * 16 * scaleFactor * GraphicsGlobalScale, 
				0, 
				scaleFactor * GraphicsGlobalScale, 
				scaleFactor * GraphicsGlobalScale, 
				0, 
				0
			)
		end
	end
end
