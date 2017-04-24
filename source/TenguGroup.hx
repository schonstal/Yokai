
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class TenguGroup extends FlxSpriteGroup {
  var lastCameraScroll:Float = 0;

  public function new():Void {
    super();

    var e = new TenguEnemy(100, 100);
    e.init();
    add(e);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if (FlxG.camera.scroll.y < lastCameraScroll) {
      trySpawningEnemies();
    }

    lastCameraScroll = FlxG.camera.scroll.y;
  }

  private function trySpawningEnemies():Void {
    var newEnemy = cast(recycle(TenguEnemy), TenguEnemy);
    newEnemy.init();
  }
}
