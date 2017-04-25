package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class GameOverGroup extends FlxSpriteGroup {
  var gameOverSprite:FlxSprite;

  public function new():Void {
    super();
    exists = false;
    gameOverSprite = new FlxSprite();
    gameOverSprite.loadGraphic("assets/images/gameover.png");
    add(gameOverSprite);

    scrollFactor.x = scrollFactor.y = 0;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
