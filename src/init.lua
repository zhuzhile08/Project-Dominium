require "utility"

function love.load()
	GraphicsGlobalScale = 2

	-- refactor into loadAssets
	love.graphics.setDefaultFilter("nearest", "nearest")
	TilesetTexture = love.graphics.newImage("data/Image/tileset.png")

	-- love.mouse.setCursor(love.mouse.newCursor("data/Image/cursor.png", 8, 8))

	initTilemapSystem()

	Tilemap = generateTilemap(os.time(), 20, 30)
end
