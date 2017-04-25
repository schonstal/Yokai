
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class TenguGroup extends FlxSpriteGroup {
  var lastCameraScroll:Float = 0;

  public function new():Void {
    super();

    var e = new TenguEnemy();
    e.y = 20;
    e.init();
    add(e);

    if (Reg.random.float(0, 1) < 0.5) {
      e.x = 40;
    } else {
      e.x = FlxG.width - e.width - 40;
    }
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }

  public function spawn(X:Float, Y:Float):Void {
    var newEnemy = cast(recycle(TenguEnemy), TenguEnemy);
    newEnemy.init();
    newEnemy.x = X;
    newEnemy.y = Y;
    add(newEnemy);
  }
}
