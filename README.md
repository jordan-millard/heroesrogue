# Heroes Rogue
Singleplayer rogue-like mod for Heroes of the Storm.

<img width="1919" height="1080" alt="heroesrogue" src="https://github.com/user-attachments/assets/25dcc8fc-9d86-49cf-ac81-ccc224881242" />

This is a fork of [sobbyellow/heroesrogue](https://github.com/sobbyellow/heroesrogue). It adds 11 more battlegrounds, ARAM challenges, many more Golden Heroes, Mythic scaling for objectives and neutral camps, and new boons and curses. See **What's New in This Fork** below. Work happens on the `dev` branch.


## **How to Play**

- Download `HeroesRogue.<version>.zip` from this fork's [latest release](https://github.com/jordan-millard/heroesrogue/releases/latest). Fork releases are named after the original version they build on, e.g. `v0.17.2-fork.1`; the Releases on the original repo are the original mod without these changes. For the very newest (untested) changes, download the [dev branch as a zip](https://github.com/jordan-millard/heroesrogue/archive/refs/heads/dev.zip) instead.

- Extract the zip and copy its `maps` and `mods` folders into your Heroes of the Storm installation folder (e.g. `C:/Program Files (x86)/Heroes of the Storm`), merging with the folders already there. The `maps` and `mods` folders must end up next to the Heroes of the Storm executable's folders (`Support64`, `Versions`, ...).

- Start the game, open the menu in the bottom right (cog icon), press Challenges, and then press Play.

- To update, close the game completely, copy the new `maps` and `mods` folders over the old ones, and start the game again. The game caches mod data, so starting a new match without restarting the game keeps the old version.

## **Getting All the Maps to Work**

Out of the box you get Cursed Hollow, Garden of Terror, Blackheart's Bay and Sky Temple. The game only plays offline maps properly from 4 fixed paths, so the other battlegrounds (Haunted Mines, Infernal Shrines, Tomb of the Spider Queen, Towers of Doom, Dragon Shire, Volskaya Foundry, Battlefield of Eternity, Hanamura Temple, Alterac Pass, Braxis Holdout and Warhead Junction) and the ARAM maps (Industrial District, Braxis Outpost, Silver City, Lost Cavern) need a small helper that swaps the chosen map into the Sky Temple slot before it loads.

1. Copy the `maps` and `mods` folders as above. The spare maps are in `maps/heroes/singleplayermaps/rotation`.
2. Double-click `tools/map-rotation/install-map-rotation.cmd` (in the extracted zip) once. It finds your game folder, starts the helper right away and adds it to Windows startup, so it runs every time you log in. While the game is closed it only keeps the default maps in place, so copying an update over the folders stays safe.
3. In game, open the options menu (cog icon) and check **Extra maps**. The map choice screen now offers every battleground, and ARAM challenges can appear.

- The helper must be running before a match on an extra map loads. If it isn't, the game plays whichever map is in the slot (Sky Temple) and says so in chat. Run `install-map-rotation.cmd` again to restart it.
- To remove it, double-click `tools/map-rotation/uninstall-map-rotation.cmd`.

## **How to Uninstall**

- Remove the `maps` and `mods` folders to get regular Try Mode back, and run `uninstall-map-rotation.cmd` if you installed the helper.



# **Info**

Welcome to Heroes Rogue! This is a singleplayer rogue-like mod for Heroes of the Storm. Throughout the game, you will have to choose Boons providing various permanent buffs and Curses which make the game more difficult. Your boons and curses are automatically saved after destroying the enemy Core, carrying them over into the next game. The game can be quit and played at another time, and will resume where you left off. You win by getting to round **14**! If your Core gets destroyed, the run ends and all boons and curses are reset.

**Map Choice:** At the start of a run (after picking your Hero) and after every win, you choose the next battleground from 3 options. Each option shows the AI allies and enemies you will play with and against on that map. The map pool is Cursed Hollow, Garden of Terror, Blackheart's Bay, and Sky Temple, plus Haunted Mines, Infernal Shrines, Tomb of the Spider Queen, Towers of Doom, Dragon Shire, Volskaya Foundry, Battlefield of Eternity, Hanamura Temple, Alterac Pass, Braxis Holdout, and Warhead Junction with Extra Maps installed.

**ARAM Challenges:** With Extra Maps on, winning round 4 or round 8 leads to an ARAM challenge instead of the next round. Pick one of 3 ARAM maps (Industrial District, Braxis Outpost, Silver City, Lost Cavern), each showing the 3 AI Heroes you will face alone: ranged assassins after round 4, and tanks with 20% more Health after round 8. Destroy their Core to earn an Uncommon or better boon at the start of the next game. If you die once or lose, you get a curse instead. A challenge does not count as a game: the round does not advance, there are no boons or curses during the match, and it does not affect run stats, achievements, or missed boons and curses. Each challenge can be turned off in the options menu, and both are skipped when playing Cho'Gall.

The following Heroes have special interactions with boons and curses:<br>
- **Lost Vikings, Rexxar, Samuro, and Nova:** Boons and curses apply to all controlled units/clones.<br>
- **Abathur:** Boons and curses apply to Symbiote (NOT the host) and Ultimate Evolution.<br>
- **Cho'Gall:** Cho and Gall share all boons and curses.<br>

**Golden Heroes:** These Heroes have access to unique boons and curses, in addition to the generic ones that all Heroes have access to.

**Boons:** Obtained when reaching level 1, 4, 7, and 10. If you win early and skip any boons, those skipped boons will be offered in the next game, up to the level 10 boons. Completing a map objective (for example getting three tributes on Cursed Hollow) also replaces a future curse with a boon, once per game. Boons can be Common, Uncommon, Rare, Epic, Legendary, or Mythic, increasing in rarity and power. You are guaranteed at least a Rare Boon at the start of every game, and a Legendary Boon every 4 games.

**Milestone Boons:** These are boons with unique effects that are obtained when reaching round 7 on any difficulty as a milestone reward.

**Starter Boons:** These are potent boons that can only be obtained at the start of the game. Some boons only show up with specific starter boons.

**Curses:** Obtained every time the enemy Team reaches a talent tier, as well as level 24, 27, and 30. If you win early and skip any curses, those skipped curses will be offered in the next game, up to the level 10 curses.

**Mythic Curses:** These are powerful and unique curses that show up at the start of the game and every 4 games afterwards on Mythic difficulty.

**Challenge Curses:** These are curses that can be difficult to deal with but offer great rewards.

**Rerolls:** Obtain 3 rerolls at the start of a run and 1 additional reroll at the start of every subsequent game which can be used to reroll the selection of boons and curses. Boon rerolls and curse rerolls are separate.

**Bans:** Obtain 3 bans at the start of a run and 1 additional ban at the start of every subsequent game which can be used to ban boons and curses, preventing them from showing up for the rest of the run. Infinite boons/curses, starter boons, mythic curses, and milestone boons cannot be banned.



# **What's New in This Fork**

### Maps
- **Map choice screen** after picking your Hero and after every win, showing the AI Heroes on each side.
- **11 more battlegrounds** with the map rotation helper (see above), each reporting its objective so a completed objective still swaps a curse for a boon. Winning before any objective finishes gives the first objective's swap.
- **ARAM challenges** after rounds 4 and 8 (see Info).
- **Map curses** for the new battlegrounds: Hostile Takeover (Volskaya), Wounded Immortal (Battlefield of Eternity), Drek'thar's Command (Alterac Pass), Brood Mother (Braxis Holdout, +15% Health for enemy Zerg), Shimada Honor (Hanamura) and Mutually Assured Destruction (Warhead Junction).
- **Convenient Portals** works on every map. Maps without hand-placed portal spots get them where the side lanes cross the middle.
- Lighting fixes for Towers of Doom and Battlefield of Eternity.

### Mythic Scaling for Objectives, Mercenaries and Bosses
Mythic scales every enemy unit (Heroes, structures, and the camps and bosses they win) by up to +252% damage and Health. Before, your own side stayed at base strength, so in long Mythic runs your objectives and mercenaries were paper and theirs flattened you.
- **Neutral mercenary camps and bosses** get half of the round's Mythic bonus, so they don't melt in late rounds.
- **Your team's** captured mercenaries, bosses, map objective units and vehicles (Dragon Knight, Garden Terror, Triglav Protector and the like) also get half the bonus.
- **Objective damage to enemy structures** is raised to cancel the structures' Mythic Health bonus, so objectives do what they would in a normal game. This covers objective units plus Sky Temple shots, Blackheart's cannonballs, Warhead nukes and the Hanamura payload.

### Golden Heroes
The original mod's Golden Heroes are Illidan, Lost Vikings, Muradin, Probius, Sgt. Hammer, Thrall, Tyrande, Nazeebo and Li-Ming. This fork adds these, most with 3 starters and their own boons and quests:

| Hero | Starters |
|---|---|
| Alarak | Tal'darim Ascendant, Lightning Lord, Highlord |
| Anub'arak | Scarab Lord, Crypt Lord, Traitor King |
| Azmodan | Lord of Annihilation, Lord of Sin, General of the Burning Hells |
| Chen | Stormstout Inferno, Iron Ox, Drunken Master |
| E.T.C. | Headliner, Amplified, Rock Legend |
| Falstad | Wildhammer's Wrath |
| Genji | Shuriken Storm, Blade of the Shimada, Dragon Master |
| Gul'dan | Fel Lord, Soul Harvester, Corruptor |
| Jaina | Frost Mage, Blizzard Caller, Elementalist |
| Junkrat | Trap King, Nade Spam, Rocket Rodeo |
| Kael'thas | Sunfire, Bombardier, Pyromancer |
| Kel'Thuzad | Lord of Decay, Frostbinder, Chains of the Lich |
| Kerrigan | Queen of Blades, Impaler, Brood Mother |
| Lunara | Poisoner, Splintered Huntress, Pollinator |
| Murky | Slime King, Big Tuna, Mrrgl Warrior |
| Nova | Deadeye, Crippling Fire, Holo Corps |
| Orphea | Shadow Dancer, Abyssal Maw, Dreadbringer |
| Sonya | Spin to Win, Seismic Brute, Ancient Hunter |
| Stukov | Lurking Hunger |
| Sylvanas | Dark Ranger, Shadow Queen, Banshee |
| Tassadar | Eye of the Storm, Templar's Lance |
| Tracer | Gunslinger, Brawler, Bomber |
| Valla | Hungering Hunter, Multishot Marksman, Strafe Queen |
| Xal'atath | Void Herald, Shadow Seer, Heart of Darkness |
| Zagara | Hive Mother, Acid Queen, Swarm Matriarch |
| Zeratul | Void Blade, Singularity, Dark Templar |
| Zul'jin | Axe Thrower, Whirling Axes, Headhunter |

Abathur (Minefield) and Butcher (Prime Cuts) also get a starter each, in place of All Talents.

How the new golden starters work:
- Most starters focus on one ability: it gets extra charges or a lower cooldown, half its Mana cost, and a couple of talents.
- **Hit quest:** each enemy Hero hit adds a little damage. It keeps **50%** of its stacks after a win.
- **Takedown quest:** each enemy Hero takedown shortly after a hit adds a stack. It keeps **100%**. The stacks improve the ability in stages (cooldown, then area or speed, and sometimes an echo or a third reward), then add damage once past the cap.
- Quest talents that a starter or a boon grants, and the Hero's own built-in quests, keep **50%**.
- Every starter has a Common boon that gives **+15% damage per stack** with no limit, as its own multiplier.

### New Boons and Rarities
- **Reverse Hex** (Legendary, stacks without limit): flips a random stat curse onto the enemy team. The curse it will flip is shown while it is offered. It is only offered while a curse can be flipped.
- **Grand Reversal** (new **Mythic** boon rarity, rarer than Legendary; about 10% of Legendary rolls become Mythic): flips one of your Mythic curses onto the enemy team. Any Mythic curse except Eternal can be flipped. A flipped Mythic curse is no longer handed out; Mythic rounds give the next lower one instead.

### Other Changes
- **Possession curse:** possessed minions keep their enemy stats and buffs (Mythic, Sappers, Armored Up and so on), and a possessed leader is ready to convert right away.
- **No more stuck talent picks:** when boons grant or disable every talent on a tier, a hidden "do nothing" talent appears so the later tiers can still be picked.
- **Faster loading, room for more heroes:** only the generic affixes and your own Hero's affixes are loaded.
- Fixed quest stacks being added more than once when several boons keep the same quest.
- Quick Mount is no longer offered to Abathur.

#### Discord:
Raven's Court has a [heroes-rogue-chat](https://discord.com/invite/EpgEauXgK7) channel for Heroes Rogue.

#### Credits:
sobbyellow for [Heroes Rogue](https://github.com/sobbyellow/heroesrogue), which this fork is built on.

Errorb0t for his [list of all boons and curses.](https://errorb0t.github.io/heroesrogue/index.html)

Jamie Phan for his [Try Mode resources and documentation.](https://jamiephan.net/HeroesOfTheStorm_TryMode2.0/)

#### Disclaimer:
This is a fan-made project and is not affiliated with or endorsed by Blizzard Entertainment. The mod runs locally and does not interact with Blizzard's servers. All original game assets, characters, and intellectual property belong to Blizzard Entertainment.
