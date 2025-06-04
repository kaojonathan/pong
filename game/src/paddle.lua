local Paddle = {}

function Paddle:new(width, height, xpos, ypos)
	local inst = {
		width = width or 10,
		height = height or 50,
		xpos = xpos,
		ypos = ypos
	}
	return inst
end


return Paddle
