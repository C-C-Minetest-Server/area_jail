# Area Protection Jails

This mod helps moderators to jail players, i.e. preventing them from leaving a certan place.

## How to set up a jail

1. Protect areas using the `areas` mod. Note that the area should be the minimum area jailed players should access, NOT the whole jail building. Remember the area IDs.
2. Pick a spawn point. That point will be the first spot a newly jailed player is located and where escaped players are placed. The point must be located within the areas.
3. Decide a jail ID. The ID can be any string, as long as there are no spaces inside it. The jail ID will refer to this jail when jailing players.
4. Execute this command: `/jailset <jail ID> <area IDs> <spawnpoint>`. Note that there should not be any spaces between the area IDs.

## How to jail and release players

Jailing and releasing players require the target to be online.

To jail a player, execute `/jail <player name> <jail ID>`. The player will be teleported into the jail and will be caught back in the jail if they somehow manage to escape.

To release a player, execute `/unjail <player name>`. The player will now be free to leave, and if possible, be teleported to one of the following locations:

1. The static spawn point set in `minetest.conf`.
2. The `/home` point of the player.
3. The last position of the player before they were jailed.
