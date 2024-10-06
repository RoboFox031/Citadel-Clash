Enemies added:
    *Ball Enemy:
        This enemy is the defult enemy, it has no special abalities, and just folows the path. It come in three varieties, with increasing amounts of health
    *Splitter Enemy:
        This enemy splits into more enemies when defeated. While coding it, it took me a while to get the spread of the splitted enemies just right, I didn't want them spawning too close toghether, or else it would be hard to tell how many of them there were, and I also wanted all of them to spawn behind the parent spliter, to prevent them from potential spawning too close to the end to be stopped.
    *Blocker Enemy:
        This enemy creates a fireball sheild around itself and others every couple seconds. Any projectiles inside the sheild are deleted. This enemy wasn't too hard to code in, the sheild was a bit finicky at first, but now it works
    *Genral Enemy Notes:
        The enemies all run off the same script, this was because at the time, I didn't know that you could have things extend classes, I did this correctly with my towers, but my enemies have lots of export varables to allow them to all run of the same code.
Towers Added:
    #Arrow Tower:
        The arrow tower shoots arrow and was my first shot at making a tower. It took me a while to get everything working correctly, I kept running into timing issues with the animation and such, but I got it working after lots of trial and error
    #Melee/Magic Tower:
        In the files, I refer to this tower as the "melee tower",  however in the game, I refer to it as the "Magic Tower". I just decided that magic tower sounded beter. The magic tower attacking through sheilds was originally a bug, as the wave it attacks with isn't a projectile, so the sheild wouldn't delete it. I decided that this was a nice feature to keep in the game, to make the blocker enemies more managable.
    #Lightning Tower:
        Getting the lightning to chain correctly took an entire Sunday of coding. I wasn't sure how to approach it at first, but eventully gave the lightning a range hitbox of its own, it chains off of enemies inside.
    #Genral Tower Notes:
        All the projetiles are tracking projectiles, so I don't have to worry about deleting things offscreen
Other things:
    Econony: 
        Originally, you would get ~200 coins per wave, and the most expensive tower (lightning) cost the player 100 coins. I fixed this by making towers more expensive, and enemies worth less coins
    Tower Placement:
        The only bug (that I know of) that I couldn't figure out to fix is that of the placement system. When a tower stops touching a tower, and a invalid placement spot at the same time, it gets stuck in a not red mode, even if you then touch another thing that should make it turn red. The game still won't let you place towers there, so it's not too play affecting

Overall, this project was very fun, and I can't wait for what we do next in this class!