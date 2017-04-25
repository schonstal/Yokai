package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class ControlsGroup extends FlxSpriteGroup {
  var moveLetterPad:FlxSprite;
  var moveText:FlxBitmapText;
  var uppercutText:FlxBitmapText;
  var slashText:FlxBitmapText;

  var background:FlxSprite;

  public function new():Void {
    super();

    scrollFactor.x = scrollFactor.y = 0;

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/alphabetMono.png",
      "abcdefghijklmnopqrstuvwxyz",
      new FlxPoint(8, 9)
    );

    background = new FlxSprite();
    background.loadGraphic("assets/images/controls.png");
    add(background);

    moveText = new FlxBitmapText(font);
    moveText.text = "move";
    moveText.letterSpacing = -1;
    moveText.x = 81;
    moveText.y = 118;
    add(moveText);

    moveLetterPad = new FlxSprite();
    moveLetterPad.loadGraphic("assets/images/fonts/letterpad.png");
    moveLetterPad.x = moveText.x - 1;
    moveLetterPad.y = moveText.y;
    add(moveLetterPad);

    uppercutText = new FlxBitmapText(font);
    uppercutText.letterSpacing = -1;
    uppercutText.text = "uppercut";
    uppercutText.x = 195;
    uppercutText.y = moveText.y;
    add(uppercutText);

    slashText = new FlxBitmapText(font);
    slashText.letterSpacing = -1;
    slashText.text = "forward slash";
    slashText.x = 113;
    slashText.y = 183;
    add(slashText);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
