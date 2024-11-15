# Entities

An entity refers to something that exists and can be identified as a distinct and independent unit.

Although many things outside this folder can be an entity, this external things have they own folder based on other definitions.

Entity examples:
	- Player
	- Enemies
	- NPCs
	- Itens
	- Skills

Non Entity examples:
	- Environments: anything from the world that the user doesn't interact with it;
	- Assets: Although each entity have they own assets, you shouldn't use this folder for reusable assets;
	- Menus: Although the user can interact with it, the player doesn't. And most of components reused by menus are just used by them and not by the player.

As you can see, this folder is more for things that the player "character" can interact with somehow.
