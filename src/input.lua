local inputSystem = { }
inputSystem.__index = inputSystem

-- for example, love.keyboard.isDown would be an input for stateFunction
function inputSystem.new(stateFunction)
	local self = setmetatable({ }, inputSystem)

	self.stateFunction = state
	self.inputs = { }

	return self
end

function inputSystem:add(input)
	table.insert(self.inputs, input)
end

-- DeltaTime would be a typical example for args

function inputSystem:update(args)
	for _, v in pairs(self.inputs) do
		v.reset()

		if self.state(v.name) then
			v.run(args)
		end
	end

	table.clear(self.inputs)
end

local basicInput = { }
basicInput.__index = basicInput

function inputSystem.new(name, func)
	local self = setmetatable({ }, basicInput)

	self.name = name
	self.run = func

	return self
end

return inputSystem, basicInput
