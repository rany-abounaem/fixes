void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);

	if (!player) {

		player = new Player(nullptr);

		if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // Delete the player before returning
			delete player;
			return;
		}
	}

	Item* item = Item::CreateItem(itemId);

	if (!item) {
        // Item was not created so no need to delete
		return;
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
    // Item has been utilized so it should be deleted as it has no purpose anymore
	delete item;

	if (player->isOffline()) {

		IOLoginData::savePlayer(player);
        // In case the player was retrieved using IOLoginData into the pointer that reserved an address,
        // it should be deleted
		delete player;
	}

}