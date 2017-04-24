import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.addons.display.FlxStarField.FlxStarField2D;

@:access(flixel.addons.display.FlxStarField2D.starVelocityOffset)

class SnowBackground extends FlxStarField2D {
  public function new() {
    super(0, 0, FlxG.width, FlxG.height, 50);
    scrollFactor.x = scrollFactor.y = 0;
    setStarSpeed(10, 20);
    starVelocityOffset = FlxPoint.get(-0.5, 1);
    setStarDepthColors(5, 0xff585858, 0xffF4F4F4);
    bgColor = 0xff3c081f;
  }
}
