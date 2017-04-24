import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.system.FlxSound;

class ShootingEnemy extends Enemy {
  var shootTimer:Float = 2;
  var shootTime:Float = 2;

  public function new(X:Float = 0, Y:Float = 0) {
    super();

    x = X;
    y = Y;

    loadGraphic("assets/images/enemies/shooter.png", true, 19, 23);
    animation.add("idle", [0], 5, true);
    animation.add("shoot", [1, 2], 10, false);
    animation.finishCallback = onAnimationComplete;
    animation.play("idle");
  }

  public override function update(elapsed:Float):Void {
    shootTimer -= elapsed;
    if (shootTimer <= 0) {
      shoot();
      shootTimer = shootTime;
    }
    super.update(elapsed);
  }

  function shoot():Void {
    animation.play("shoot");

    Reg.enemyProjectileService.shoot(
      x + 6,
      y + 6,
      facing == FlxObject.RIGHT ? new FlxVector(1, 0) : new FlxVector(-1, 0)
    );
  }

  function onAnimationComplete(name:String):Void {
    animation.play("idle");
  }
}
