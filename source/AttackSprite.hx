package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class AttackSprite extends FlxSprite {
  inline static var ATTACK_TIME = 0.2;

  var attackTimer:FlxTimer;

  public function new() {
    super();

    loadGraphic("assets/images/player/attack.png", true, 32, 32);
    animation.add("slash", [0], 15, true);
    visible = false;
  }

  public function attack(name) {
    animation.play(name, true);
    visible = true;
    attackTimer = new FlxTimer().start(ATTACK_TIME, function(t) {
      visible = false;
    });
  }
}
