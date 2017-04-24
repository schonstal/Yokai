package;

import flixel.FlxSprite;
import flixel.FlxG;

class EnemyExplosion extends FlxSprite {
  var isPlayer:Null<Bool> = null;

  public function new() {
    super();
    animation.finishCallback = onAnimationComplete;
  }

  public function initialize(X:Float, Y:Float):Void {
    exists = true;
    x = X;
    y = Y;

    loadGraphic("assets/images/enemies/explosion.png", true, 32, 32);
    offset.x = 16;
    offset.y = 16;
    animation.add("explode", [0, 1, 2, 3, 4, 5, 6], 15, false);
  }

  public function explode():Void {
    animation.play("explode");
  }

  function onAnimationComplete(name:String):Void {
    exists = false;
  }
}
