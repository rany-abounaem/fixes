function printSmallGuildNames(memberCount)

    -- this method is supposed to print names of all guilds that have less than memberCount max members
    
    -- This is a nested query to group guilds by id then count their members,
    -- after that, the guild name is retrieved from those guilds with members lower than input
    local selectGuildQuery = "SELECT name FROM guilds INNER JOIN (SELECT guild_id, COUNT(guild_id) AS members FROM guild_membership GROUP BY guild_id) y ON guilds.id = y.guild_id WHERE members > %d; "
    
    local query = db.storeQuery(string.format(selectGuildQuery, tonumber(memberCount)))

    if query == false then
        return
    else
        -- loop through result (if any) and print name
        repeat
            local guildName = result.getDataString(query, "name")
            print (guildName)   
        until result.next(query) == false
    end
    
    if (query ~= false) then
        result.free(query)
    end
    
end
