local vec2 = {}
vec2.__index = vec2

vec2.__add = function(a, b)
    if getmetatable(a) ~= "vec2" or getmetatable(b) ~= "vec2" then
         return vec2.new()
    end

    local x = a.x + b.x
    local y = a.y + b.y

    return vec2.new(x, y)
end

vec2.__sub = function(a, b)
    if getmetatable(a) ~= "vec2" or getmetatable(b) ~= "vec2" then
         return vec2.new()
    end

    local x = a.x - b.x
    local y = a.y - b.y

    return vec2.new(x, y)
end

vec2.__mul = function(a, b)
    if type(a) == "table" and type(b) == "table" then
        if getmetatable(a) ~= "vec2" or getmetatable(b) ~= "vec2" then
            return vec2.new()
        end
        local x = a.x * b.x
        local y = a.y * b.y
        return vec2.new(x, y)
    elseif type(a) == "number" then
        return vec2.new(b.x * a, b.y * a)
    elseif type(b) == "number" then
        return vec2.new(a.x * b, a.y * b)
    end

    return vec2.new()
end

vec2.__div = function(a, b)
    if type(a) == "table" and type(b) == "table" then
        if getmetatable(a) ~= "vec2" or getmetatable(b) ~= "vec2" then
            return vec2.new()
        end
        local x = a.x / b.x
        local y = a.y / b.y
        return vec2.new(x, y)
    elseif type(a) == "number" then
        return vec2.new(b.x / a, b.y / a)
    elseif type(b) == "number" then
        return vec2.new(a.x / b, a.y / b)
    end

    return vec2.new()
end

vec2.__tostring = function(a)
   return "["..a.x..", "..a.y.."]" 
end

vec2.__metatable = "vec2"

function vec2:Lerp(a, t)
    if getmetatable(a) ~= "vec2" then
        return vec2.new()   
    end

    local t = t or 0

    if t > 1 then 
        t = 1 
    elseif t < 0 then 
        t = 0 
    end

    local b = (a - self) * vec2.new(t, t)
    
    return b + self
end

function vec2.new(x, y)
    local self = setmetatable({}, vec2)
    
    x = x or 0
    y = y or 0
    
    self.x = x
    self.y = y
    self.X = x
    self.Y = y
    
    self.Magnitude = function()
       return math.sqrt((x^2) + (y^2))
    end
    
    self.Unit = function()
       local d = self.Magnitude()
       return self / vec2.new(d, d)
    end
    
    return self
end

return vec2
