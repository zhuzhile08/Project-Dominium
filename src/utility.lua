function tprint(tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
	  	if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
	  	elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
	  	elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
	  	else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
	 	 end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end -- hippity hoppity your code is now my property

function tblcpy(tbl) -- thanks Bill
	local newTbl = {}

	for i, v in pairs(tbl) do
		if type(v) == "table" then
			newTbl[i] = tblcpy(v)
		else
			newTbl[i] = v
		end
	end

	return newTbl
end

function fprint(f, ...) -- explicit file print
	f:write(...)
	f:flush()
end

function fprint(...)
	LogFile:write(...)
	LogFile:flush()
end

function degToRad(deg)
	return deg * math.pi / 180
end

function radToDeg(rad)
	return rad * 180 / math.pi
end
