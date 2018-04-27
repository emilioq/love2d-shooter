enemy = {}
enemy.width = 25
enemy.height = 25
enemy.speed = 1000 
enemy.friction = 7.5

e1Snd1 = love.audio.newSource("e1boost.wav", "static")
e1Snd2 = love.audio.newSource("e1boost2.wav", "static")
e1Snd3 = love.audio.newSource("e1boost3.wav", "static")
e1kill = love.audio.newSource("kill.wav")

e1Snd1:setVolume(0.9)
e1Snd2:setVolume(0.9)
e1Snd3:setVolume(0.9)
e1kill:setVolume(0.5)

function enemy.spawn(x,y)
	table.insert(enemy, {x=x, y=y, xvel=0, yvel=0, health=2, width = enemy.width, height = enemy.height, speed = enemy.speed, timeLimit = 1})
end

function enemy.draw()

	--ENEMY THEMSELVES
	for i,v in ipairs(enemy) do
		if v.health > 0 then
		love.graphics.setColor(70,100,180)
		love.graphics.rectangle('line', v.x, v.y, v.width, v.height)
		end
	end

	--ENEMY LINE CONNECTION
	for i,v in ipairs(enemy) do
		for o=1,table.getn(enemy) do




			

			love.graphics.setColor(80,120,80)

			--COLLISION HIT LINE WHITE
			if hitlimit > 0 then
				love.graphics.setColor(255,255,255)
			end

			--LINE DRAWN
			if v.health > 0 then
				if enemy[o].health > 0 then
					love.graphics.line(v.x, v.y, enemy[o].x, enemy[o].y)
					love.graphics.line(v.x + v.width, v.y, enemy[o].x + enemy[o].width, enemy[o].y)
					love.graphics.line(v.x, v.y + v.height, enemy[o].x, enemy[o].y + enemy[o].height)
					love.graphics.line(v.x + v.width, v.y + v.height, enemy[o].x + enemy[o].width, enemy[o].y + enemy[o].height)
				end
			end	
		end
	end

end

function enemy.physics(dt)
	for i, v in ipairs(enemy) do
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel * dt
		v.yvel = v.yvel * (1 - math.min(dt * enemy.friction, 1))
		v.xvel = v.xvel * (1 - math.min(dt * enemy.friction, 1))

		if v.health == 1 and v.width == v.height then
			local chance = love.math.random(0,1)

			if chance == 0 then
				v.width = v.width / 2
			end

			if chance == 1 then
				v.height = v.height / 2
			end
		end

		if v.health == 0 then
			if e1kill:isPlaying() then e1kill:stop() end
			e1kill:play()
			v.health = -1
		end
	end
end

function enemy.AI(dt)
	for i, v in ipairs(enemy) do
		if v.health > 0 then
			--X AXIS
			if player.x + player.width / 2 < v.x + v.width / 2 then
				if v.xvel > -enemy.speed then
					v.xvel = v.xvel - v.speed * dt
				end
			end

			if player.x + player.width / 2 > v.x + v.width / 2 then
				if v.xvel < enemy.speed then
					v.xvel = v.xvel + v.speed * dt
				end
			end

			--Y AXIS
			if player.y + player.width / 2 < v.y + v.width / 2 then
				if v.yvel > -enemy.speed then
					v.yvel = v.yvel - v.speed * dt
				end
			end

			if player.y + player.width / 2 > v.y + v.width / 2 then
				if v.yvel < enemy.speed then
					v.yvel = v.yvel + v.speed * dt
				end
			end
		end


		--EXPERIENCE
		if v.health < 0 then
			--X AXIS
			if  math.abs( ( player.x + player.width / 2 ) - ( v.x + v.width / 2 ) ) <= 100 and math.abs( ( player.y + player.width / 2 ) - ( v.y + v.height / 2 ) ) <= 100 then
				if player.x > v.x then
					v.xvel = 10000 * dt
				end

				if player.x < v.x then
					v.xvel = -10000 * dt
				end

				if player.y > v.y then
					v.yvel = 10000 * dt
				end

				if player.y < v.y then
					v.yvel = -10000 * dt
				end
			end

			if  math.abs( ( player.x + player.width / 2 ) - ( v.x + v.width / 2 ) ) > 100 then
				v.xvel = 0
			end

			--Y AXIS

			if  math.abs( ( player.y + player.width / 2 ) - ( v.y + v.height / 2 ) ) > 100 then
				v.yvel = 0
			end
		end
	end
end


--PARENT FUNCTION
function DRAW_ENEMY()
	enemy.draw()
end

function UPDATE_ENEMY(dt)
	enemy.physics(dt)
	enemy.AI(dt)

	for i, v in ipairs(enemy) do
		if v.health > 0 then
			local chance = math.random(1,4)

			if chance == 1 and v.timeLimit == 0 then
				if e1Snd2:isPlaying() then e1Snd3:play() end
				e1Snd2:play()
				v.speed = v.speed + 500
				v.timeLimit = 1 + math.random(0,2)
			elseif v.timeLimit == 0 then
				v.speed = enemy.speed + love.math.random(-500, 500)
				v.timeLimit = 1 + math.random(0,2)
			end

			if v.speed >= 1850 then
				if e1Snd1:isPlaying() then e1Snd3:play() end
				e1Snd1:play()
			end

			v.timeLimit = math.max(0, v.timeLimit - dt)
		end
	end
end
