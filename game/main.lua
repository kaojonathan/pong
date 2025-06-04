Ball = require("src.ball")
Paddle = require("src.paddle")


WIND_WIDTH = 800
WIND_HEIGHT = 600

local ball = {}
local p1 = {}
local p2 = {}

function love.load()
	-- load the paddles
	p1 = Paddle:new(nil, nil, 5, WIND_HEIGHT / 2)
	p2 = Paddle:new(nil, nil, WIND_WIDTH - 15, WIND_HEIGHT / 2)

	-- load the ball
	ball = Ball:new(10, WIND_WIDTH / 2, WIND_HEIGHT / 2, 100)

end

function love.update()
end

function love.draw()
	-- draw paddles
	love.graphics.rectangle("fill", p1.xpos, p1.ypos, p1.width, p1.height)
	love.graphics.rectangle("fill", p2.xpos, p2.ypos, p2.width, p2.height)

	-- draw ball
	love.graphics.circle("fill", ball.xpos, ball.ypos, ball.radius)
end
