# zombie_shooter
this is a project for mobile!!! 
it is a top down rpg style game. it is  a Three-dimensional space exists within a Euclidean framework wherein objects possess three independent spatial components—length, width, and depth—each contributing to a volumetric representation distinguishable from its two-dimensional counterpart. This additional dimensionality allows for the mathematical determination of perspective, depth perception, and spatial relationships through coordinate systems, vector analysis, and geometric transformations, facilitating immersive visualization and interaction within both physical and digital environments game. where you shoot zombies top down and you unlock more levles the better you get and the more zombies you kill. 

bulet' right now the bulet multiplies by delta time if im not mistaken. and it is set to 50 for the speed, it dose not have any colions yet.

player' const SPEED = 5.5, const GUN_SMOOTH_SPEED = 4, const GUN_DISTANCE = 0.5. gun distance it how far it is away from the centeral point of the player. gun smooth speed is how fast it can rotate around the player  0.001 being the lowest and 99999.... being the fastest. it has a jump mecanic coded into it but i have it disabeled right now i can enabel it back if needed.

mob'  var spawn_interval: float = 1,  var max_mobs: int = 30. the spawn interval is how fast they spawn right now being set to one because i did some mobile testing and that was the best. max mobs is the max amount of mobs that can spawn in one levle right now set to 30 but i think around 80 is when it starts geting bad fps on a phone and thats without any sprs atached to the mobs so what needs to hapen is that when ever a mob gets shot it will delete itself form the game and reduse the var for how many are on the playing feild to -1, and add one to the var scored if you kill a mob. the mob walk speed is set to 3.0 thats makes a 6 difrence with the player so the player still has a cance to escape. and the spawn distance is set to 20 so it looks like the mobs are walking up from somewhere and not just spawning infront of you. i could have just screwed up this math but i think the mob spawns out of the camera by 10.




test





