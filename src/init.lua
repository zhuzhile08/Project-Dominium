require "utility"
require "Tilemap.tilemap"
require "input"
local camera = require "Entities.camera"

function loadAssets()
	love.graphics.setDefaultFilter("nearest", "nearest")
	GroundTilesetTexture = love.graphics.newImage("data/Image/GroundTileset.png")
	WaterTilesetTexture = love.graphics.newImage("data/Image/WaterTileset.png")
end

function initGameComponents()
	Camera = camera.new(0, 0, 0, GraphicsGlobalScale, GraphicsGlobalScale)
end

function love.load()
	GraphicsGlobalScale = 2

	-- log file
	LogFile = assert(io.open("src/log.txt", "w"))

	loadAssets()
	initInputSystems()
	initGameComponents()
	initTilemapSystem()

	local i = 1
	while i < 50 do
		s, _ = pcall(function() 
			i = i + 1
			Tilemap = generateTilemap(os.time(), 30, 30)
		end)
	end
end
