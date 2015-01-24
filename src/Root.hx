import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import Std;

class Root extends Sprite {

	public static var assets:AssetManager;
	public var square1:Image;
	public var square2:Image;

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

    	var number1 = makeSquare(square1, 100, 100);
    	var number2 = makeSquare(square2, 100, 500);
    }

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


}