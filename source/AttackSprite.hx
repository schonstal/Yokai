package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class AttackSprite extends FlxSprite {
  inline static var ATTACK_TIME = 0.2;

  var attacking:Bool = false;
  var attackTimer:FlxTimer;

  var hitList:Array<FlxObject>;

  public var isAttacking(get, null):Bool;
  public function get_isAttacking():Bool {
    return attacking;
  }

  public function new() {
    super();

    loadGraphic("assets/images/player/smears.png", true, 64, 64);
    animation.add("attack 1", [0, 1, 2, 3, 4], 20, false);
    animation.add("attack 2", [5, 6, 7, 8, 9], 20, false);
    animation.finishCallback = onAnimationComplete;
    visible = false;
    attacking = false;
    solid = false;

    hitList = [];

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function attack(name) {
    animation.play(name, true);
    visible = true;
    attacking = true;
    FlxG.sound.play("assets/sounds/player/attack1.ogg");
    solid = true;
    hitList.splice(0, hitList.length);
  }

  public function collideWith(object:FlxObject) {
    if (hitList.indexOf(object) < 0) {
      object.hurt(10);
      hitList.push(object);
    }
  }

  private function onAnimationComplete(animation:String):Void {
    visible = false;
    attacking = false;
    solid = false;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);


    if (facing == FlxObject.LEFT) {
      x = Reg.player.x - 36;
    } else {
      x = Reg.player.x;
    }

    y = Reg.player.y;
  }
}
