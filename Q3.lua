function kickPartyMember(playerId, memberName)

    local player = Player(playerId)
    local playerToKick = Player(memberName)
    local party = player:getParty()

    for k,v in pairs(party:getMembers()) do
    
        if v == playerToKick then
            party:removeMember(playerToKick)
        end

    end
end