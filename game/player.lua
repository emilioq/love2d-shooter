player = {}

function player.load()
	player.x = 250
	player.y = 250
	player.xvel = 0
	player.yvel = 0
	player.friction = 7
	player.speed = 2500
	player.width = 15
	--player.height = 15


	player.limit = 2
	player.health = 3
	player.level = 1

	player.exprotate = 0
end

function player.draw()

	--PLAYER AND AIM
	love.graphics.setColor(255,100,100)
	love.graphics.circle("line",player.x,player.y,player.width,player.height)
	love.graphics.line(player.x, player.y, love.mouse.getX(), love.mouse.getY())

	--PLAYER HEALTH
	if player.health == 3 then
		love.graphics.print("3", player.x + 15, player.y + 5, 0, 1)
	end

	if player.health == 2 then
		love.graphics.print("2", player.x + 15, player.y + 5, 0, 1)
		player.width = 10
	end

	if player.health == 1 then
		love.graphics.print("1", player.x + 15, player.y + 5, 0, 1)
		player.width = 5
	end

	if player.health == 0 then
		love.graphics.print("Game Over", player.x + 15, player.y + 5, 0, 1)
		player.width = 1
	end

	--PLAYER-ENEMY

	for i,v in ipairs(enemy) do
		if v.health == 2 then 
			love.graphics.setColor(100,85,85)
			love.graphics.line(player.x, player.y, v.x + v.width/2, v.y + v.height/2)
		end
		
		if v.health == 1 then 
			love.graphics.setColor(60,50,50)
			love.graphics.line(player.x, player.y, v.x + v.width/2, v.y + v.height/2)
		end
	end

end

function player.exp()
	for i,v in ipairs(enemy) do
		if v.health == -1 then
			love.graphics.setColor(225,215,115)
			love.graphics.print("*", v.x + v.width/2, v.y + v.height/2, player.exprotate, 1.75)
		end
	end
end

function player.physics(dt)
	player.x = player.x + player.xvel * dt
	player.y = player.y + player.yvel * dt
	--player.yvel = player.yvel + gravity * dt
	player.yvel = player.yvel * (1 - math.min(dt * player.friction, 1))
	player.xvel = player.xvel * (1 - math.min(dt * player.friction, 1))
end

function player.move(dt)
	if love.keyboard.isDown('d') and player.xvel > -player.speed 
		then player.xvel = player.xvel + player.speed * dt
	end

	if love.keyboard.isDown('a') and player.xvel < player.speed 
		then player.xvel = player.xvel - player.speed * dt
	end

	if love.keyboard.isDown('w') and player.xvel > -player.speed 
		then player.yvel = player.yvel - player.speed * dt
	end

	if love.keyboard.isDown('s') and player.xvel < player.speed 
		then player.yvel = player.yvel + player.speed * dt
	end
end


--[[
function player.boundary()
	if player.x < 0 then 
		player.x = 0 
		player.xvel = 0
	end

	if player.y + player.height > groundlevel then
		player.y = groundlevel - player.height
		player.yvel = 0
	end
end
]]


--PARENT FUNCTIONS
function DRAW_PLAYER()
	player.draw()
	player.exp()
end
function UPDATE_PLAYER(dt)
	player.physics(dt)
	--player.boundary()
	player.move(dt)

	player.exprotate = player.exprotate - dt / 2
end


