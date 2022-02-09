I am not 100% sure Berzerk Ultimate is bug free, I think I remember that once I could shoot thru walls. 
And Thomas said that he had a shot go thru the player. 
I never “discovered” these bugs, although I was looking/searching for them. 
I did some code changes afterwards and they might or might not be gone. 
But having played quite a lot of games recently – I have not found anything wrong… perhaps you will? 

(Please give feedback if so).

More information on my pages: http://vide.malban.de/?s=berzerk

-------------

Fixes done so far:

    bonus display bug fixed
    shoot thru wall bug fixed
    to many shots bug fixed (shots now limited to 32, but more was probably never reached)
    displayes most of the time in 50Hz
    no “prisoners” anymore
    no “double” drawn walls
	
Additions done:

    like in the “arcade” Berzerk, robot shots can now be shot by player shots
    also a max robot-shot speed of 7 (which is still quite fast)
    color mode, when enabled, displays BERZERK in Arcade Jason color mode*
    VecVox support (similar to Verzerk, but that one added VecVoice support)*
    Highscore list (5 scores) can be saved to VecFever or DS 2431*
    Intro-Screen
	
	
In order to do the above I did:

    Incorporate all known changes done in Berzerk II (unreleased changes done by MB) and Berzerk debugged (changes by Fred Taft).
    labyrinth generation:
    added functions, that examine the labyrinth for prisons/double draws, and changed the labyrinth when that happened
    labyrinth display:
    Changed the display routines of the maze.
    shots changed:
    shots are internally not an “ever growing” array (including dead shots) anymore, instead a linked list of “active” shots
    display of the robots changed to smartlist:
    before each robot was drawn with 7 (seven!!!) seperate vectorlists, which formed all animation steps, only 8 different “complete” lists are needed for all animations
    display of player changed to smartlist:
    befor the player was “constructed” of
    – body
    – arms (left/right (anims), 8 shot directions)
    – legs (left/right (anims))
    score display:
    in a two player game, only the active score is displayed, not both
    changed the shot handling:
    Before shots with a speed of say 5, increased position information 5 times per round (with 1), and 5 times all checkings (hit wall, hit player, hit robot) were done, this was immensely time consuming. The new detection functions handle all high speed detections in one go.
    seperated the “scroll” display from the static display (scrolling of the labyrinth)
    and probably some other changes.