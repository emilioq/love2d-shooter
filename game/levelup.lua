local lvlCount = 0


local sprite = love.graphics.newImage("introSprite.png")
anim = newAnimation(sprite,18,19,0.05, 0)
anim:setMode("once")


lvlUp = love.audio.newSource("levelup.wav")

function count()
	if table.getn(enemy) == 0 then
		lvlCount = lvlCount + 1
		--enemy.spawn(500)
	end

	if lvlCount == 1 then
		lvlUp:play()
		if lvlUp:isPlaying() then 
			lvlCount = 1
		else 
			lvlCount = 0
		end
	end
end

function levelupUpdate(dt)
	count()
	if lvlUp:isPlaying() then
		anim:update(dt)
	end
end

function levelupDraw()
	if lvlUp:isPlaying() then
		anim:draw(600-18/2,375-19/2)
	end
end