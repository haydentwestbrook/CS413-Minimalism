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

	public function new() {
		super();
	}

	public function start(startup:Startup) {

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
                        run();
               			}

                });
            }

        });
    }

    public function run() {

    	rand1 = makeSquare(square1, 100, 100);
    	rand2 = makeSquare(square2, 100, 500);

    	Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
    	Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchPress);

    };

    public function makeSquare(square:Image, x:Int, y:Int) {
    	var rand = Std.random(3);

    	if(rand == 0) {
    		square = new Image(Root.assets.getTexture("redSquare"));
    	} else if(rand == 1) {
    		square = new Image(Root.assets.getTexture("blueSquare"));
    	} else if(rand == 2) {
    		square = new Image(Root.assets.getTexture("greenSquare"));
    	}
    	square.x = x;
    	square.y = y;
    	addChild(square);

    	return rand;
    }

    public function touchPress(e:TouchEvent) {
    	var t:Touch = e.getTouch(this);
    	if(t != null) {
			switch(t.phase) {
				case TouchPhase.ENDED:
					//log("Touch Ended");
	 				makeSquare(square1, 100, 100);
			} 
		}
	}

	public function keyPress(e:KeyboardEvent) {
	 	makeSquare(square1, 100, 100);
	}


}