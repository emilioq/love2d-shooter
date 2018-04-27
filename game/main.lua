require "player"
require "bullet"
require "enemy"
require "map"
require "AnAL"
require "collision"
require "levelup"

function love.load()
	love.graphics.setBackgroundColor(0,0,0)

	love.mouse.setVisible(false)
	--love.mouse.setGrabbed(true)

	--Loading Classes
	player.load()

	enemy.spawn(500, 500)
	enemy.spawn(150, 200)
	enemy.spawn(330, 750)
	enemy.spawn(200, 150)
	enemy.spawn(410, 300)
end

function love.update(dt)
	if dt < 1/60 then
		love.timer.sleep(1/60 - dt)
	end

	
	UPDATE_PLAYER(dt)
	UPDATE_BULLET(dt) 
	UPDATE_ENEMY(dt)
	UPDATE_COLLISION (dt)
	map_collide()

	levelupUpdate(dt)
end

function love.draw()
	love.graphics.setColor(255,100,100)
	love.graphics.circle('line', love.mouse.getX(), love.mouse.getY(), 5)



	DRAW_PLAYER()
	DRAW_BULLET()
	DRAW_ENEMY()

	levelupDraw()
end