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
	self.inputs[input.name] = input
end

function inputSystem:remove(name)
	self.inputs[name] = nil
end

-- DeltaTime would be a typicsl example for args

function inputSystem:update(args)
	for _, v in pairs(self.inputs) do
		v.reset()

		if self.state(v.name) then
			v.run(args)
		end
	end
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
