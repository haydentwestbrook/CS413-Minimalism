import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.events.KeyboardEvent;
import starling.events.TouchEvent;
import starling.events.Touch;
import starling.events.TouchPhase;
import Std;


class Root extends Sprite {



	public static var assets:AssetManager;
	public var square1:Image;
	public var square2:Image;
	public var rand1:Int;
	public var rand2:Int;
    public var speed = 5;
    

	public function new() {
		super();
	}

	public function start(startup:Startup) {

        //Removes loading screen and begins run()

        assets = new AssetManager();
        assets.enqueue("assets/redSquare.png");
        assets.enqueue("assets/blueSquare.png");
        assets.enqueue("assets/greenSquare.png");
        assets.loadQueue(function onProgress(ratio:Float) {

            if (ratio == 1) {

                Starling.juggler.tween(startup.loadingBitmap, 2.0, {
                    transition: Transitions.EASE_OUT,
                        delay: 1.0,
                        alpha: 0,
                        onComplete: function() {
                        startup.removeChild(startup.loadingBitmap);
                        run(speed);
               			}

                });
            }

        });
    }
    
 
    public function run(speed:Int) {
        
      
        //Responsible for main game loop
        
        

        //Set up squares
    	makeSquare1();
    	makeSquare2();


        Starling.juggler.repeatCall(makeSquare1, speed, 0);

        //User input listeners

    	Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
    	Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchPress);

        

    };

    public function makeSquare1() {
        //Randomly sets the color for square1
    	rand1 = Std.random(3);

    	if(rand1 == 0) {
    		square1 = new Image(Root.assets.getTexture("redSquare"));
    	} else if(rand1 == 1) {
    		square1 = new Image(Root.assets.getTexture("blueSquare"));
    	} else if(rand1 == 2) {
    		square1 = new Image(Root.assets.getTexture("greenSquare"));
    	}
    	square1.x = 100;
    	square1.y = 100;
    	addChild(square1);
    }

    public function makeSquare2() {
        //Randomly sets the color for square1
        rand2 = Std.random(3);

        if(rand2 == 0) {
            square2 = new Image(Root.assets.getTexture("redSquare"));
        } else if(rand2 == 1) {
            square2 = new Image(Root.assets.getTexture("blueSquare"));
        } else if(rand2 == 2) {
            square2 = new Image(Root.assets.getTexture("greenSquare"));
        }
        square2.x = 100;
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
        if(rand1 == rand2) {
            //Won the game
            run(speed--);
        } else {
            //Game over

        }
    }


}
