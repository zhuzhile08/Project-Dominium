require "utility"
require "Tilemap.tilemap"
require "input"

local vec2 = require "vector2"
local camera = require "Entities.camera"
local player = require "Entities.player"

function loadAssets()
	love.graphics.setDefaultFilter("nearest", "nearest")
	GroundTilesetTexture = love.graphics.newImage("data/Image/GroundTileset.png")
	WaterTilesetTexture = love.graphics.newImage("data/Image/WaterTileset.png")
end

function initGameComponents()
	Camera = camera.new(0, 0, 0, GraphicsGlobalScale, GraphicsGlobalScale)
	Player = player.new(0, 0, 0, 1, 1, 300)

	Camera:target(Player)
end

function love.load()
	GraphicsGlobalScale = 2

	TilemapWidth = 50
	TilemapHeight = 50

	-- log file
	LogFile = assert(io.open("src/log.txt", "w"))

	loadAssets()
	initInputSystems()
	initGameComponents()
	initTilemapSystem()

	--[[

	local i = 1
	while i < 50 do
		s, _ = pcall(function() 
			i = i + 1
			Tilemap = generateTilemap(os.time(), 100, 100)
		end)
	end

	--]]

	Tilemap = generateTilemap(os.time(), TilemapWidth, TilemapHeight)
end
