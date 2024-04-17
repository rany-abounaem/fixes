function kickPartyMember(playerId, memberName)

    -- get player who used the function
    local player = Player(playerId)
    -- get player to kick
    local playerToKick = Player(memberName)
    -- get player's party
    local party = player:getParty()

    -- loop through party members
    for k,v in pairs(party:getMembers()) do
    
        -- if it matches with playerToKick, then remove from party
        if v == playerToKick then
            party:removeMember(playerToKick)
        end

    end
end