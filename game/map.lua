function map_collide()
	if player.x < 15 then
		player.x = 15
	end

	if player.y < 15 then
		player.y = 15
	end

	if player.x > 1185 then
		player.x = 1185
	end

	if player.y > 735 then
		player.y = 735
	end

end

