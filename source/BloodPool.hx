import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class BloodPool extends FlxSpriteGroup {
  inline static var RISE_SPEED:Float = 20;
  inline static var MAX_SPEED:Float = 40;

  var riseSpeed:Float = RISE_SPEED;
  var sinAmt:Float = 0;

  public function new() {
    super();
    var backdrop = new FlxSprite(0, FlxG.height);
    backdrop.makeGraphic(FlxG.width, FlxG.height * 2, 0xff3c081f);
    add(backdrop);

    for (i in (0...Std.int(FlxG.width/16))) {
      var bloodSprite = new FlxSprite(i * 16, FlxG.height - 16);
      bloodSprite.loadGraphic("assets/images/blood.png", true, 16, 32);
      bloodSprite.animation.add("pulse", [0, 1, 2, 3], 10, true);
      bloodSprite.animation.play("pulse");
      bloodSprite.immovable = true;
      add(bloodSprite);
    }
  }

  public override function update(elapsed:Float):Void {
    sinAmt += 3.0 * elapsed;
    var i = 0;
    for (bloodSprite in members) {
      i++;
      bloodSprite.offset.y = 2 * Math.sin(sinAmt + i);
    }

    if (!Reg.started && Reg.player.alive) {
      super.update(elapsed);
      return;
    }

    riseSpeed += elapsed/4;
    if (riseSpeed >= MAX_SPEED) {
      riseSpeed = MAX_SPEED;
    }

    if (y > FlxG.camera.scroll.y) {
      y = FlxG.camera.scroll.y;
    }

    y -= riseSpeed * elapsed;

    if (y < FlxG.camera.scroll.y - FlxG.height) {
      y = FlxG.camera.scroll.y - FlxG.height;
    }
    super.update(elapsed);
  }
}
