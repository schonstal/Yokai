
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class TenguGroup extends FlxSpriteGroup {
  var lastCameraScroll:Float = 0;

  public function new():Void {
    super();

    var e = new TenguEnemy(40, 140);
    e.init();
    add(e);
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
