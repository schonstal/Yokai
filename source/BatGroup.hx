
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class BatGroup extends FlxSpriteGroup {
  var lastCameraScroll:Float = 0;

  public function new():Void {
    super();

    var e = new BatEnemy(100, 100);
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
    var newEnemy = cast(recycle(BatEnemy), BatEnemy);
    newEnemy.init();
  }
}
