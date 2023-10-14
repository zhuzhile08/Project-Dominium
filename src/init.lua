require "utility"
local socket = require'socket'

function love.load()
	GraphicsGlobalScale = 2

	-- refactor into loadAssets
	love.graphics.setDefaultFilter("nearest", "nearest")
	TilesetTexture = love.graphics.newImage("data/Image/tileset.png")

	-- love.mouse.setCursor(love.mouse.newCursor("data/Image/cursor.png", 8, 8))

	initTilemapSystem()

	local s = false
	while not s do
		s, _ = pcall(function() 
			print("reset")
			Tilemap = generateTilemap(socket.gettime(), 30, 30)
		end)
	end
end
