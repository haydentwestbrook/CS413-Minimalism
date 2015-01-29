import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;
import starling.events.Touch;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.animation.IAnimatable;
import Std;
import flash.events.Event;
import flash.media.SoundChannel;




class Root extends Sprite {



	public static var assets:AssetManager;
	public var square1:Image;
	public var square2:Image;
	public var rand1:Int = -1;
	public var rand2:Int = -1;
    public var speed:Float = 2.0;
    public var fastestSpeed:Float = .4;
    public var maxRand = 3;
    public var points:Int = 0;
    public var misses:Int = 0;
    public var scoreText:TextField;
    public var levelText:TextField;
    public var missText:TextField;
    public var repeat:IAnimatable;
    public var background:Image;
    public var level:Int = 1;
    public var bgmusic:SoundChannel; 
    public var beep:SoundChannel;


    
    

	public function new() {
		super();
	}

	public function start(startup:Startup) {

        //Removes loading screen and begins run()

        assets = new AssetManager();

        assets.enqueue("assets/bgmusic.mp3");
        assets.enqueue("assets/beep.mp3");
        assets.enqueue("assets/wrong.mp3");

        assets.enqueue("assets/background1.png");
        assets.enqueue("assets/background2.png");
        assets.enqueue("assets/background3.png");
        assets.enqueue("assets/background4.png");
        assets.enqueue("assets/background5.png");

        assets.enqueue("assets/redSquare.png");
        assets.enqueue("assets/blueSquare.png");
        assets.enqueue("assets/greenSquare.png");
        assets.enqueue("assets/yellowSquare.png");
        assets.enqueue("assets/orangeSquare.png");
        assets.enqueue("assets/purpleSquare.png");
        
        assets.enqueue("assets/circle_red.png");
        assets.enqueue("assets/circle_blue.png");
        assets.enqueue("assets/circle_green.png");
        assets.enqueue("assets/circle_yellow.png");
        assets.enqueue("assets/circle_orange.png");
        assets.enqueue("assets/circle_purple.png");

        assets.enqueue("assets/red_triangle.png");
        assets.enqueue("assets/blue_triangle.png");
        assets.enqueue("assets/green_triangle.png");
        assets.enqueue("assets/yellow_triangle.png");
        assets.enqueue("assets/orange_triangle.png");
        assets.enqueue("assets/purple_triangle.png");

       

        assets.loadQueue(function onProgress(ratio:Float) {

            if (ratio == 1) {

                background = new Image(Root.assets.getTexture("background" + level));
                this.addChild(background);
                Starling.juggler.tween(startup.loadingBitmap, 2.0, {
                    transition: Transitions.EASE_OUT,
                        delay: 1.0,
                        alpha: 0,
                        onComplete: function() {
                        startup.removeChild(startup.loadingBitmap);
                        
                        listenerInit();
               			}

                });
            }

        });
    }
    public function displayLevel(){
        // creates level text field
        levelText = new TextField(200, 190, "Level: ", "Impact", 24, 0x33CC33);
        this.addChild(levelText);
        levelText.text += level;
    }
    public function updateLevel(){
        this.removeChild(levelText);
    }
    public function displayScore(){
        // creates score text field
        scoreText = new TextField(200, 50, "Matches: ", "Impact", 24, 0x33CC33);
        this.addChild(scoreText);
        scoreText.text += points;
    }
    
    public function updateScore(){
        // removes old score value
        this.removeChild(scoreText);
    }

    public function displayMisses() {
        // creates misses text field
        missText = new TextField(200, 120, "Misses: ", "Impact", 24, 0x33CC33);
        this.addChild(missText);
        missText.text += misses;
    }
        public function updateMisses(){
        // removes old miss value
        this.removeChild(missText);
    }


    public function nextLevel(){
        speed = 2.0;
        if(fastestSpeed > .25) {
            fastestSpeed = fastestSpeed * .75;
        }
        if(maxRand < 12) {
            maxRand += 3;
        } else if(maxRand < 18) {
            maxRand += 6;
        }
        if(level < 5) {
            level++;
            this.removeChild(background);
            background = new Image(Root.assets.getTexture("background" + level));
            this.addChild(background);
        }
        run(speed, maxRand);
    }
    
    public function listenerInit(){
        assets.playSound("bgmusic");
        // function adds listeners once so they are not looped
        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchPress);

        run(speed, maxRand);
    }
    public function run(speed, maxRand) {
        // updates then displays users current score
        updateScore();
        displayScore();

        updateMisses();
        displayMisses();

        updateLevel();
        displayLevel();


        //Set up squares
    	makeSquare1(maxRand);
    	makeSquare2(maxRand);
        
        repeat = Starling.juggler.repeatCall(makeSquare1, speed, 0, maxRand);
    };

    public function makeSquare1(maxRand:Int) {
        //Randomly sets the color for square1
        var oldRand = rand1;
    	rand1 = Std.random(maxRand);
        while(oldRand == rand1) {
            rand1 = Std.random(maxRand);
        }

    	var color:Array<String> = ["redSquare", "blueSquare", "greenSquare", "yellowSquare", "orangeSquare", "purpleSquare",
                                   "circle_red", "circle_blue", "circle_green", "circle_yellow", "circle_orange", "circle_purple",
                                   "red_triangle", "blue_triangle", "green_triangle", "yellow_triangle", "orange_triangle", "purple_triangle"];

        removeChild(square1);
        square1 = new Image(Root.assets.getTexture(color[rand1]));
    	square1.x = 235;
    	square1.y = 0;
    	addChild(square1);
    }

    public function makeSquare2(maxRand:Int) {
        //Randomly sets the color for square2
        var oldRand = rand2;
        rand2 = Std.random(maxRand);
        while(oldRand == rand2) {
            rand2 = Std.random(maxRand);
        }

        var color:Array<String> = ["redSquare", "blueSquare", "greenSquare", "yellowSquare", "orangeSquare", "purpleSquare",
                                   "circle_red", "circle_blue", "circle_green", "circle_yellow", "circle_orange", "circle_purple",
                                   "red_triangle", "blue_triangle", "green_triangle", "yellow_triangle", "orange_triangle", "purple_triangle"];

        removeChild(square2);
        square2 = new Image(Root.assets.getTexture(color[rand2]));
        square2.x = 235;
        square2.y = 330;
        addChild(square2);
    }

    public function touchPress(e:TouchEvent) {
    	var t:Touch = e.getTouch(this);
    	if(t != null) {
			switch(t.phase) {
				case TouchPhase.ENDED:
	 				checkWin();
			} 
		}
	}

	public function keyPress(e:KeyboardEvent) {
	 	checkWin();
	}

    public function checkWin() {
        if(rand1 == rand2){
            assets.playSound("beep");
            points++;
            if(speed <= fastestSpeed){
                // player at lowest speed already, if speed of 0 or -1 is reached, it will crash, so go to next level?

                Starling.juggler.remove(repeat);
                nextLevel();
            }
            else{
                // match made and speed above 1, so runs loop again but with faster speed
                
                Starling.juggler.remove(repeat);
                speed = speed * .75;
                run(speed, maxRand);
            }   
        }
        else{
            // stays in loop with no change in speed
            assets.playSound("wrong");
            misses++;
            updateScore();
            displayScore();
            updateMisses();
            displayMisses();
            updateLevel();
            displayLevel();
            if(misses >= 5) {
                gameOver();
            }
        }
    }

    public function gameOver() {
        Starling.juggler.remove(repeat);
        Starling.current.stage.dispose();
        var gameOverText = new TextField(625, 450, "Game Over", "Impact", 48, 0xC91010);
        this.addChild(gameOverText);
    }
}
