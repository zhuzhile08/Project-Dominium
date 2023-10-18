local inputSystem = { }
inputSystem.__index = inputSystem

-- for example, love.keyboard.isDown would be an input for stateFunction
function inputSystem.new(stateFunction)
	local self = setmetatable({ }, inputSystem)

	self.stateFunction = stateFunction
	self.inputs = { }

	return self
end

function inputSystem:add(input)
	table.insert(self.inputs, input)
end

-- DeltaTime would be a typical example for args

function inputSystem:update(args)
	for _, v in pairs(self.inputs) do
		if self.stateFunction(v.name) then
			v.run(args)
		end
	end

	self.inputs = { }
end

function initInputSystems()
	KeyboardInputSystem = inputSystem.new(love.keyboard.isDown)
end

local basicInput = { }
basicInput.__index = basicInput

function basicInput.new(name, func)
	local self = setmetatable({ }, basicInput)

	self.name = name
	self.run = func

	return self
end

return basicInput
