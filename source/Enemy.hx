package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxObject;

import flash.geom.ColorTransform;

class Enemy extends FlxSprite {
  var flashTimer:FlxTimer;
  var explosionTimer:FlxTimer;
  var explosionRate:Float = 0.2;
  var deathTimer:FlxTimer;

  var deathTime:Float = 0;
  var deathWidth:Float = 0;
  var deathHeight:Float = 0;

  var points:Int;

  var explosionOffset:FlxPoint;
  var explosionCount:Int = 1;

  public var onDeath:Void->Void;

  public function new() {
    super();
    health = 30;
    points = 50;
    flashTimer = new FlxTimer();
    explosionTimer = new FlxTimer();
    deathTimer = new FlxTimer();
    explosionOffset = new FlxPoint(0, 0);
  }

  public override function hurt(damage:Float):Void {
    if (!alive) return;

    Reg.pointService.showPoints(x + width/2, y + height/2, Std.int(damage));

    FlxG.camera.shake(0.005, 0.2);

    super.hurt(damage);
    flash();
  }

  public override function kill():Void {
    setColorTransform();
    color = 0xff8c4a53;
    alive = false;

    blowUp();
    die();
  }

  function blowUp():Void {
    FlxG.camera.shake(0.005, 0.2);
    for(i in 0...explosionCount) {
      Reg.enemyExplosionService.explode(x + width/2 + explosionOffset.x,
                                        y + height/2 + explosionOffset.y,
                                        deathWidth, deathHeight);
    }
  }

  function die():Void {
    exists = false;
    if (onDeath != null) onDeath();
  }

  public function flash():Void {
    useColorTransform = true;
    setColorTransform(0, 0, 0, 1, 0, 0, 0, 0);

    flashTimer.start(0.025, function(t) {
      setColorTransform(0, 0, 0, 1, 255, 255, 255, 0);

      flashTimer.start(0.025, function(t) {
        setColorTransform();
      });
    });
  }

  public function spawn():Void {
    alive = true;
    exists = true;
    setColorTransform();
  }

  public function onStart():Void {
  };

  public function adjustHitbox():Void {
    if (FlxG.keys.justPressed.Q) {
      facing = FlxObject.LEFT;
    }

    if (FlxG.keys.justPressed.E) {
      facing = FlxObject.RIGHT;
    }

    if (FlxG.keys.justPressed.LEFT) {
      offset.x += 1;
    }

    if (FlxG.keys.justPressed.RIGHT) {
      offset.x -= 1;
    }

    if (FlxG.keys.justPressed.UP) {
      offset.y += 1;
    }

    if (FlxG.keys.justPressed.DOWN) {
      offset.y -= 1;
    }

    if (FlxG.keys.justPressed.W) {
      height += 1;
    }

    if (FlxG.keys.justPressed.S) {
      height -= 1;
    }

    if (FlxG.keys.justPressed.A) {
      width -= 1;
    }

    if (FlxG.keys.justPressed.D) {
      width += 1;
    }

    FlxG.log.notice("width: " + width);
    FlxG.log.notice("height: " + height);
    FlxG.log.notice("offset.x: " + offset.x);
    FlxG.log.notice("offset.y: " + offset.y);
    return;
  }
}
