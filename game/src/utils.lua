local utils = {}

function utils.distance(x1, y1, x2, y2)
	local x = x2 - x1
	local y = y2 - y1

	return math.sqrt(x^2+y^2)
end

return utils
