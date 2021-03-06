package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVector;

class Projectile extends FlxSprite {
  inline static var SPEED:Float = 200;

  var dangerTimer:Float = 0;
  var dangerTime:Float = 0.04;

  public var reflected:Bool = false;

  public function new() {
    super();

    loadGraphic("assets/images/bullet.png", true, 12, 5);

    width = 6;
    height = 6;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function initialize(X:Float, Y:Float, direction:FlxVector, spawnFacing:Int):Void {
    x = X;
    y = Y;

    visible = true;
    facing = spawnFacing;
    exists = true;
    reflected = false;

    dangerTimer = 0;

    velocity.x = direction.x * SPEED;
    velocity.y = direction.y * SPEED;
  }

  public function isDangerous():Bool {
    return !reflected && dangerTimer >= dangerTime;
  }

  public function reflect(heading:Int = FlxObject.LEFT):Void {
    reflected = true;
    facing = heading;
    color = 0xff33ff33;

    if (facing == FlxObject.LEFT) {
      velocity.x = -SPEED * 2;
    } else {
      velocity.x = SPEED * 2;
    }
  }

  override public function update(elapsed:Float):Void {
    dangerTimer += elapsed;

    super.update(elapsed);
  }
}
