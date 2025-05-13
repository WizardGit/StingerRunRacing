StingerRunRacing
Racing Simulation with Speed Stingers!
This is a standard 3D Unity project on version 2021.2.14f1

Kaizar The Sneak Unity Play: https://play.unity.com/u/KaizarTheSneak
Game Link: https://play.unity.com/mg/other/webglbuilds-245
Website Link: https://wizardgit.github.io/StingerRunRacingWebsite/index.html

TODO:
package srr into a game installer
add an inventory to freeroam
add wandering boat in lake to level four
add wandering speedstinger pack to freeroam or part of quest?
add human class
Add purposes and comments to scripts
Make sure invisible walls are there!
button click noises
fix forbidden ice track
Add heather on warlord island
get speed hoop prefabs
change arrow to follow camera movements (like if you turn backwards)
allow npcs to get speed boxes!

Other (Future) Ideas:
Create a dragon flight simulator except you can roll sideways and forward
fireball frenzy with admin heads on targets
war simulator with characters - you can set waypoints to be enemies and draw lines or maybe triggers to detect others
you could do an astrid is going to attack quest, or something stupid like that

Debuggin:
fix dance scene cutoff
fix old scene image behind canvas
create some sort of template for the canvas
fix water not on minimap
fix jump while already in air bug
fix the inefficient code for placement script
boost timer is doing most of the stuff in playercontroller instead of playerracingcontroller
when resetting user, the link to smash n' dash is still there, until you come  back from another scene
fix how ice level is saved!
I put the dreadstrider swimming animations on speedstinger
fix issue with npc dragon being in water!
fix having to load all the dragon skin materials
fix trees being all billboards
fix arrow being weird
add some effect when fireball hits a dragon

https://play.unity.com/u/KaizarTheSneak
https://answers.unity.com/questions/1725269/how-to-rename-a-script.html
https://stackoverflow.com/questions/63036126/floating-objects-in-unity
https://nerd-breached-containment.tumblr.com/post/617212697336020992/how-to-export-sod-models-into-blender
https://nerd-breached-containment.tumblr.com/post/617222478324006912/how-to-add-a-color-mask-to-the-sod-dragons

For adding a new skin:
Update UserSave.CreateUser() update the for loop for more skins
Add skin materials to canvas (StoreScript) list for ss and ds
Add skim materials to prefab model (player controller) materials list
Saves are here:
C:\Users\USERNAME\AppData\LocalLow\DragonClub\StingerRunRacing