package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class AttackSprite extends FlxSprite {
  inline static var ATTACK_TIME = 0.2;
  inline static var STOP_FRAMES = 5;

  var attacking:Bool = false;
  var attackTimer:FlxTimer;

  var hitList:Array<FlxObject>;

  var timeFrames:Int = 0;

  var currentHitbox:Dynamic;
  var attackHitboxes:Dynamic = {
    "attackOne": {
      left: {
        x: -3,
        offsetX: 0
      },
      right: {
        x: 5,
        offsetX: 15
      },
      y: -9,
      offsetY: 0,
      width: 46,
      height: 28,
      damage: 10,
      energy: 5
    },

    "attackTwo": {
      left: {
        x: 9,
        offsetX: 12
      },
      right: {
        x: 4,
        offsetX: 15
      },
      y: -9,
      offsetY: 0,
      width: 40,
      height: 36,
      damage: 15,
      energy: 5
    },

    "uppercut": {
      left: {
        x: 0,
        offsetX: 0
      },
      right: {
        x: 0,
        offsetX: 15
      },
      y: 0,
      offsetY: 0,
      width: 46,
      height: 28,
      damage: 25,
      energy: 30
    }
  };

  public var isAttacking(get, null):Bool;
  public function get_isAttacking():Bool {
    return attacking;
  }

  public function new() {
    super();

    loadGraphic("assets/images/player/smears.png", true, 64, 64);
    animation.add("attackOne", [0, 1, 2, 3, 4], 20, false);
    animation.add("attackTwo", [5, 6, 7, 8, 9], 20, false);
    animation.add("uppercut", [10, 10, 10, 10, 10], 10, false);
    animation.finishCallback = onAnimationComplete;
    visible = false;
    attacking = false;
    solid = false;

    hitList = [];

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function attack(name) {
    currentHitbox = Reflect.field(attackHitboxes, name);

    width = currentHitbox.width;
    height = currentHitbox.height;
    offset.y = currentHitbox.offsetY;

    if (facing == FlxObject.LEFT) {
      offset.x = currentHitbox.left.offsetX;
    } else {
      offset.x = currentHitbox.right.offsetX;
    }

    animation.play(name, true);
    visible = true;
    attacking = true;
    FlxG.sound.play("assets/sounds/player/attack1.ogg");
    solid = true;
    hitList.splice(0, hitList.length);
    Reg.player.stamina -= currentHitbox.energy;
  }

  public function collideWith(object:FlxObject) {
    if (hitList.indexOf(object) < 0) {
      object.hurt(currentHitbox.damage);
      if (facing == FlxObject.LEFT) {
        object.x -= 10;
      } else {
        object.x += 10;
      }
      hitList.push(object);

      onLandHit();
    }
  }

  public function onLandHit():Void {
    FlxG.camera.shake(0.005, 0.2);
    stopTime();
  }

  private function stopTime():Void {
    FlxG.timeScale = 0;
    timeFrames = STOP_FRAMES;
  }

  private function onAnimationComplete(animation:String):Void {
    visible = false;
    attacking = false;
    solid = false;
  }

  public override function update(elapsed:Float):Void {
    timeFrames--;
    if (timeFrames < 0 && FlxG.timeScale == 0) {
      FlxG.timeScale = 1;
    }

    super.update(elapsed);

    updatePosition();
  }

  private function updatePosition():Void {
    if (currentHitbox == null) return;

    if (facing == FlxObject.LEFT) {
      x = Reg.player.x - 36;
      x += currentHitbox.left.x;
    } else {
      x = Reg.player.x;
      x += currentHitbox.right.x;
    }

    y = Reg.player.y;
    y += currentHitbox.y;
  }
}
