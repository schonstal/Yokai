package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HUD extends FlxSpriteGroup {
  var healthBar:HUDBar;
  var staminaBar:HUDBar;
  var scoreText:FlxBitmapText;

  public function new():Void {
    super();
    scrollFactor.x = scrollFactor.y = 0;

    staminaBar = new HUDBar(50, 14, 0xff7e979d);
    staminaBar.x = FlxG.width - 76;
    staminaBar.y = 3;
    add(staminaBar);

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 4;
    scoreText.y = 4;
    add(scoreText);
  }

  public override function update(elapsed:Float):Void {
    staminaBar.value = Reg.player.stamina;
    scoreText.text = "" + Reg.score;

    super.update(elapsed);
  }
}
