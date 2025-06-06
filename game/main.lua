Ball = require("src.ball")
Paddle = require("src.paddle")
Util = require("src.utils")


WIND_WIDTH = 800
WIND_HEIGHT = 600
P1PADDLEX = 5 -- left side of p1 paddle
P2PADDLEX = WIND_WIDTH - 15 -- left side of p2 paddle
PADDLEWIDTH = 10
PADDLEHEIGHT = 50

local ball = {}
local p1 = {}
local p2 = {}
local active = false

function love.load()
	-- load the paddles
	p1 = Paddle:new(PADDLEWIDTH, PADDLEHEIGHT, P1PADDLEX, WIND_HEIGHT / 2)
	p2 = Paddle:new(PADDLEWIDTH, PADDLEHEIGHT, P2PADDLEX, WIND_HEIGHT / 2)

	-- load the ball
	ball = Ball:new(10, WIND_WIDTH / 2, WIND_HEIGHT / 2, 100)

end

function love.keypressed(key)
	if key == "x" then
		active = true
		if p1.score == 0 and p2.score == 0 then
			ball.xvec = 1
			ball.yvec = 1
		end
	end
end

function love.update(dt)
-- paddle movement
	if love.keyboard.isDown("w") then
		if p1.ypos > 0 then
			p1.ypos = p1.ypos - 1
		end
	end
	if love.keyboard.isDown("s") then
		if p1.ypos + p1.height < WIND_HEIGHT then
			p1.ypos = p1.ypos + 1
		end
	end
	if love.keyboard.isDown("up") then
		if p2.ypos > 0 then
			p2.ypos = p2.ypos - 1
		end
	end
	if love.keyboard.isDown("down") then
		if p2.ypos + p2.height < WIND_HEIGHT then
			p2.ypos = p2.ypos + 1
		end
	end


	-- collision check bottom or top
	if ball.ypos <= 0 - ball.radius  or ball.ypos >= WIND_HEIGHT - ball.radius then
		ball.yvec = ball.yvec * -1
	end

	-- paddle collision check
	local paddleCollision = 0
	if ball.xpos - ball.radius <= p1.xpos + p1.width + 10 then
		-- p1 left paddle
		if ball.ypos < p1.ypos then
			-- top corner
			if Util.distance(ball.xpos, ball.ypos, p1.xpos + p1.width, p1.ypos) < ball.radius then
				paddleCollision = 1 
			end
		end
		if ball.ypos > p1.ypos + p1.height then
			-- bottom corner
			if Util.distance(ball.xpos, ball.ypos, p1.xpos + p1.width, p1.ypos - p1.height) < ball.radius then
				paddleCollision = 1 
			end
		end
		if ball.ypos >= p1.ypos and ball.ypos <= p1.ypos + p1.height then
			local dist = Util.distance(ball.xpos, ball.ypos, p1.xpos + p1.width, ball.ypos)
			if  dist < ball.radius then
				paddleCollision = 1 
			end
		end
	elseif ball.xpos + ball.radius >= p2.xpos - 10 	then
		-- p2 right paddle
		if ball.ypos < p2.ypos then
			-- top corner
			if Util.distance(ball.xpos, ball.ypos, p2.xpos, p2.ypos) < ball.radius then
				paddleCollision = 2 
			end
		end
		if ball.ypos > p2.ypos + p2.height then
			-- bottom corner
			if Util.distance(ball.xpos, ball.ypos, p2.xpos , p2.ypos - p2.height) < ball.radius then
				paddleCollision = 2 
			end
		end
		if ball.ypos >= p2.ypos and ball.ypos <= p2.ypos + p2.height then
			local dist = Util.distance(ball.xpos, ball.ypos, p2.xpos, ball.ypos)
			if dist < ball.radius then
				paddleCollision = 2 
			end
		end

	end
	
	if paddleCollision == 1 then
		ball.xvec = math.abs(ball.xvec)
	elseif paddleCollision == 2 then
		ball.xvec = - math.abs(ball.xvec)
	end
	


	-- ball movement
	if active then
		ball.xpos = ball.xpos + ball.speed * dt * ball.xvec
		ball.ypos = ball.ypos + ball.speed *  dt * ball.yvec
	end
	
	-- score check
	if ball.xpos < 0 then
		active = false
		ball.xpos = WIND_WIDTH / 2
		ball.ypos = WIND_HEIGHT / 2
		ball.xvec = 1
		ball.yvec = 1
		-- give p2 a point
		p2.score =  p2.score + 1 
		ball.speed = ball.speed + 10
	elseif ball.xpos > WIND_WIDTH then
		active = false
		ball.xpos = WIND_WIDTH / 2
		ball.ypos = WIND_HEIGHT / 2
		ball.xvec = -1
		ball.yvec = 1
		-- give p1 a point
		p1.score =  p1.score + 1 
		ball.speed = ball.speed + 10
	end


end

function love.draw()
	-- draw paddles
	love.graphics.rectangle("fill", p1.xpos, p1.ypos, p1.width, p1.height)
	love.graphics.rectangle("fill", p2.xpos, p2.ypos, p2.width, p2.height)

	-- draw ball
	if active then
		love.graphics.circle("fill", ball.xpos, ball.ypos, ball.radius)
	end

	-- score
	love.graphics.print("Player 1 Score: " .. p1.score, WIND_WIDTH/2 - 20, 20)
	love.graphics.print("Player 2 Score: " .. p2.score, WIND_WIDTH/2 - 20, 35)
	
	-- start button
	if not active then
		love.graphics.printf("PRESS X TO START", 0, 25, 140, 'center',0, 1.5, 1.5)
	end

end
