local Ball = {}

Ball.__index = Ball

function Ball:new(r, xpos, ypos, speed)
	local inst = {
		radius = r,
		speed = speed or 100,
		xpos = xpos,
		ypos = ypos,
		xvec = 0,
		yvec = 0
	}

	setmetatable(inst, self)
	return inst
end




return Ball
