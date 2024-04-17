local function releaseStorage(playerId, storageValue)
	-- Storage values are automatically saved in the database if the player disconnects or server save time
	-- Here, the player logged out, so we use a database call instead.
	db.query("DELETE FROM `player_storage` WHERE `player_id` = " .. playerId .. " and `key` = " .. storageValue)
end

function onLogout(player)

    local storageValue = 1000
	if player:getStorageValue(storageValue) == 1 then
		addEvent(releaseStorage, 5000, player:getGuid(), storageValue)
	end

	return true
end