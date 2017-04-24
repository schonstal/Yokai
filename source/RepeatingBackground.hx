import flixel.FlxG;
import flixel.FlxSprite;

class RepeatingBackground extends FlxSprite {
  public var otherTile:RepeatingBackground;

  public function new() {
    super();

    loadGraphic("assets/images/background/walls.png");
  }

  public override function update(elapsed:Float):Void {
    if (otherTile != null && FlxG.camera.scroll.y + FlxG.camera.height <= y) {
      y = otherTile.y - height;
    }
    super.update(elapsed);
  }
}
