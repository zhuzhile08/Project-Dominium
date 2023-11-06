require "utility"
require "Tilemap.tilemap"

local vec2 = require "vector2"
local camera = require "Entities.camera"
local player = require "Entities.player"
local solider = require "Entities.solider"

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
	Player = player.new(8, 8, 0, 1, 1, SpriteSheetQuads[77], 75)
	Solider = solider.new(8, 8, 0, 1, 1, SpriteSheetQuads[87], 65, 400)
	Solider1 = solider.new(8, 8, 0, 1, 1, SpriteSheetQuads[87], 65, 400)
	Solider2 = solider.new(8, 8, 0, 1, 1, SpriteSheetQuads[87], 65, 400)

	Camera:target(Player)
	Solider:target(Player)
	Solider1:target(Solider)
	Solider2:target(Solider1)
end

function love.load()
	GraphicsGlobalScale = 3

	TilemapWidth = 50
	TilemapHeight = 50

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
