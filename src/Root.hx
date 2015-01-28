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



class Root extends Sprite {



	public static var assets:AssetManager;
	public var square1:Image;
	public var square2:Image;
	public var rand1:Int = -1;
	public var rand2:Int = -1;
    public var speed:Float = 2.0;
    public var maxRand = 6;
    public var points:Int = 0;
    public var scoreText:TextField;
    public var repeat:IAnimatable;
    
    

	public function new() {
		super();
	}

	public function start(startup:Startup) {

        //Removes loading screen and begins run()

        assets = new AssetManager();
        assets.enqueue("assets/redSquare.png");
        assets.enqueue("assets/blueSquare.png");
        assets.enqueue("assets/greenSquare.png");
        assets.enqueue("assets/yellowSquare.png");
        assets.enqueue("assets/orangeSquare.png");
        assets.enqueue("assets/purpleSquare.png");
        assets.loadQueue(function onProgress(ratio:Float) {

            if (ratio == 1) {

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
    public function displayScore(){
        // creates score text field
        scoreText = new TextField(500, 500, "Score: ", "Arial", 24, 0xff0000);
        this.addChild(scoreText);
        scoreText.text = "Score " + points;
    }
    
    public function updateScore(){
        // removes old score value
        this.removeChild(scoreText);
    }


    public function nextLevel(){
        trace("next level reached.");
        speed = 2.0;
    }
    
    public function listenerInit(){
        // function adds listeners once so they are not looped
        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
        Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchPress);

        run(speed, maxRand);
    }
    public function run(speed, maxRand) {
        // updates then displays users current score
        updateScore();
        displayScore();


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

    	if(rand1 == 0) {
    		square1 = new Image(Root.assets.getTexture("redSquare"));
    	} else if(rand1 == 1) {
    		square1 = new Image(Root.assets.getTexture("blueSquare"));
    	} else if(rand1 == 2) {
    		square1 = new Image(Root.assets.getTexture("greenSquare"));
    	}  else if(rand1 == 3) {
            square1 = new Image(Root.assets.getTexture("yellowSquare"));
        }  else if(rand1 == 4) {
            square1 = new Image(Root.assets.getTexture("orangeSquare"));
        }  else if(rand1 == 5) {
            square1 = new Image(Root.assets.getTexture("purpleSquare"));
        }
    	square1.x = 500;
    	square1.y = 100;
    	addChild(square1);
    }

    public function makeSquare2(maxRand:Int) {
        //Randomly sets the color for square1
        var oldRand = rand2;
        rand2 = Std.random(maxRand);
        while(oldRand == rand2) {
            rand2 = Std.random(maxRand);
        }

        if(rand2 == 0) {
            square2 = new Image(Root.assets.getTexture("redSquare"));
        } else if(rand2 == 1) {
            square2 = new Image(Root.assets.getTexture("blueSquare"));
        } else if(rand2 == 2) {
            square2 = new Image(Root.assets.getTexture("greenSquare"));
        }  else if(rand2 == 3) {
            square2 = new Image(Root.assets.getTexture("yellowSquare"));
        }  else if(rand2 == 4) {
            square2 = new Image(Root.assets.getTexture("orangeSquare"));
        }  else if(rand2 == 5) {
            square2 = new Image(Root.assets.getTexture("purpleSquare"));
        }
        square2.x = 500;
        square2.y = 500;
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
        trace(rand1);
        trace(rand2);
        if(rand1 == rand2){

            trace("match");
            points++;
            if(speed <= .25){
                // player at lowest speed already, if speed of 0 or -1 is reached, it will crash, so go to next level?
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
            trace("no match");
        }
    }
}
