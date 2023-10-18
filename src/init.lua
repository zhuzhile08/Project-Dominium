require "utility"
local inputSystem, _ = require "input"

function love.load()
	GraphicsGlobalScale = 2

	-- log file
	LogFile = assert(io.open("src/log.txt", "w"))

	-- refactor into loadAssets
	love.graphics.setDefaultFilter("nearest", "nearest")
	GroundTilesetTexture = love.graphics.newImage("data/Image/GroundTileset.png")
	WaterTilesetTexture = love.graphics.newImage("data/Image/WaterTileset.png")

	-- love.mouse.setCursor(love.mouse.newCursor("data/Image/cursor.png", 8, 8))

	initTilemapSystem()

	local i = 1
	while i < 10 do
		s, _ = pcall(function() 
			i = i + 1
			Tilemap = generateTilemap(os.time(), 30, 30)
		end)
	end

	KeyboardInputSystem = inputSystem.new(love.keyboard.isDown)
end
