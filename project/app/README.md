# App

This folder compose the game. In other words, it imports all the components from outside and orchestrates them to work as the application wants to.

Which means, you shouldn't create new components inside this folder but actually just compose them to provide behaviors.

For example, outside this folder you may have:
	- Player
	- Item
	- Inventory

Inside this folder, you are going to import this 3 components and say things like:
	- Item will get out of current scene when Player touch it;
	- Player will add item to inventory;

So, item itself doesn't say if a player can take it or not, not even the player or inventory, is the app that say that.

Player and inventory is not dependent from each other, the app will actually compose them to work together.

If in the future we want to change item, player or inventory to something different, we just can change it easier.
