require "utility"
require "Tilemap.tilemap"
local inputSystem, _ = require "input"
local camera = require "Entities.camera"

function loadAssets()
	love.graphics.setDefaultFilter("nearest", "nearest")
	GroundTilesetTexture = love.graphics.newImage("data/Image/GroundTileset.png")
	WaterTilesetTexture = love.graphics.newImage("data/Image/WaterTileset.png")
end

function initInputSystems()
	KeyboardInputSystem = inputSystem.new(love.keyboard.isDown)
end

function initGameComponents()
	Camera = camera.new()
end

function love.load()
	GraphicsGlobalScale = 2

	-- log file
	LogFile = assert(io.open("src/log.txt", "w"))

	loadAssets()
	initInputSystems()
	initTilemapSystem()

	local i = 1
	while i < 10 do
		s, _ = pcall(function() 
			i = i + 1
			Tilemap = generateTilemap(os.time(), 30, 30)
		end)
	end
end
