package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class AttackSprite extends FlxSprite {
  inline static var ATTACK_TIME = 0.2;

  var attackTimer:FlxTimer;

  public function new() {
    super();

    loadGraphic("assets/images/player/smears.png", true, 64, 64);
    animation.add("slash", [0, 1, 2, 3, 4], 15, false);
    visible = false;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function attack(name) {
    animation.play(name, true);
    visible = true;
    attackTimer = new FlxTimer().start(ATTACK_TIME, function(t) {
      visible = false;
    });
  }
}
