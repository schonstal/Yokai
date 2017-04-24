package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

class Background extends FlxSpriteGroup {
  var backgroundOne:RepeatingBackground;
  var backgroundTwo:RepeatingBackground;

  public function new():Void {
    super();

    backgroundOne = new RepeatingBackground();
    backgroundTwo = new RepeatingBackground();

    backgroundOne.y = FlxG.camera.height - backgroundOne.height;
    backgroundTwo.y = backgroundOne.y - backgroundTwo.height;

    backgroundOne.otherTile = backgroundTwo;
    backgroundTwo.otherTile = backgroundOne;

    add(backgroundOne);
    add(backgroundTwo);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
