bullet = {}
bullet.width = 5
bullet.height = 5
bullet.speed = 500
bullet.limit = 0 --seconds
shootSnd = love.audio.newSource("shoot.wav", "static")


function bullet.draw()
	love.graphics.setColor(200,100,100)
	for i,v in ipairs(bullet) do
		love.graphics.rectangle("line", v.x, v.y, bullet.width, bullet.height)
	end
end


function inCollision(x1,y1,w1,h1,x2,y2,w2,h2)
	return 	x1 < x2+w2 and
			x2 < x1+w1 and
			y1 < y2+h2 and
			y2 < y1 + h1
end

--PARENT FUNCTIONS
function DRAW_BULLET() 
	bullet.draw()

	if bullet.limit > 0 then
	love.graphics.circle("fill",player.x,player.y, bullet.limit * player.width / player.limit)
	end

end

function UPDATE_BULLET(dt)
	if love.mouse.isDown('l') and bullet.limit == 0 then
		if shootSnd:isPlaying() then shootSnd:stop() end
		shootSnd:play()
		local angle = math.atan2((love.mouse.getY() - player.y), (love.mouse.getX() - player.x))

		local endX = math.cos(angle)
		local endY = math.sin(angle)

		table.insert(bullet, {x = player.x, y = player.y, dx = endX, dy = endY})
		bullet.limit = player.limit 
	end


	for i,v in ipairs(bullet) do
		v.x = v.x + (v.dx * bullet.speed * dt)
		v.y = v.y + (v.dy * bullet.speed * dt)
	end

	bullet.limit = math.max(0, bullet.limit - dt)
end
