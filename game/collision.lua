hitlimit = 0
explimit = 0
hitSnd = love.audio.newSource("hit.wav", "static")

exp1 = love.audio.newSource("exp1.wav", "static")
exp2 = love.audio.newSource("exp2.wav", "static")
exp3 = love.audio.newSource("exp3.wav", "static")
exp4 = love.audio.newSource("exp4.wav", "static")
exp5 = love.audio.newSource("exp5.wav", "static")
exp6 = love.audio.newSource("exp6.wav", "static")
exp7 = love.audio.newSource("exp7.wav", "static")
exp8 = love.audio.newSource("exp8.wav", "static")

function UPDATE_COLLISION (dt)

	for i,v in ipairs(bullet) do
		for o,p in ipairs(enemy) do
			if inCollision(v.x, v.y, bullet.width, bullet.height, p.x, p.y, p.width, p.height) == true and hitlimit == 0 and p.health > 0 then
				if hitSnd:isPlaying() then hitSnd:stop() end
				hitSnd:play()
				hitlimit = (1/25)
				p.health = p.health-1
				table.remove(bullet,i)
			end
		end
	end

	for i,v in ipairs(enemy) do
		if inCollision(v.x, v.y, 7.5, 7.5, player.x, player.y, player.width, player.width) == true and v.health < 0 then
			table.remove(enemy, i)
			if exp7:isPlaying() then exp8:play() break end 
			if exp6:isPlaying() then exp7:play() break end 
			if exp5:isPlaying() then exp6:play() break end 
			if exp4:isPlaying() then exp5:play() break end 
			if exp3:isPlaying() then exp4:play() break end 
			if exp2:isPlaying() then exp3:play() break end 
			if exp1:isPlaying() then exp2:play() break end 
			exp1:play()
		end
	end

	hitlimit = math.max(0, hitlimit - dt)

end