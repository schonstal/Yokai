package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class AttackSprite extends FlxSprite {
  inline static var ATTACK_TIME = 0.2;

  var attacking:Bool = false;
  var attackTimer:FlxTimer;

  public var isAttacking(get, null):Bool;
  public function get_isAttacking():Bool {
    return attacking;
  }

  public function new() {
    super();

    loadGraphic("assets/images/player/smears.png", true, 64, 64);
    animation.add("slash", [0, 1, 2, 3, 4], 20, false);
    animation.finishCallback = onAnimationComplete;
    visible = false;
    attacking = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function attack(name) {
    animation.play(name, true);
    visible = true;
    attacking = true;
  }

  private function onAnimationComplete(animation:String):Void {
    visible = false;
    attacking = false;
  }
}
