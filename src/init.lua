require "utility"
require "Tilemap.tilemap"

local vec2 = require "vector2"
local camera = require "Entities.camera"
local player = require "Entities.player"

function loadAssets()
	local function generateQuads(texture, cellSize)
		cellSize = cellSize or 18

		local r = { }

		for x = 1, texture:getWidth() * texture:getHeight() / cellSize * cellSize, 1 do
			r[x] = love.graphics.newQuad(
				((x - 1) % (texture:getWidth() / cellSize)) * cellSize + 1, 
				math.floor((x - 1) / (texture:getWidth() / cellSize)) * cellSize + 1, 
				16, 
				16, 
				texture:getWidth(), 
				texture:getHeight()
			)
		end

		return r
	end

	GroundTilesetTexture = love.graphics.newImage("data/Image/GroundTileset.png")
	GroundTilesetQuads = generateQuads(GroundTilesetTexture)

	WaterTilesetTexture = love.graphics.newImage("data/Image/WaterTileset.png")
	WaterTilesetQuads = generateQuads(WaterTilesetTexture)
	
	SpriteSheetTexture = love.graphics.newImage("data/Image/SpriteSheet.png")
	SpriteSheetQuads = generateQuads(SpriteSheetTexture)
end

function initGameComponents()
	Camera = camera.new(0, 0, 0, GraphicsGlobalScale, GraphicsGlobalScale)
	Player = player.new(0, 0, 0, 1, 1, SpriteSheetQuads[87], 75)

	Camera:target(Player)
end

function love.load()
	GraphicsGlobalScale = 3

	TilemapWidth = 80
	TilemapHeight = 80

	love.graphics.setDefaultFilter("nearest", "nearest")

	-- log file
	LogFile = assert(io.open("src/log.txt", "w"))

	loadAssets()
	initGameComponents()
	initTilemapSystem()

	local i = 1
	local seed = os.time()
	while i < 10 do
		s, _ = pcall(function() 
			i = i + 1
			Tilemap = generateTilemap(seed + i, TilemapWidth, TilemapHeight)
		end)
	end
end
