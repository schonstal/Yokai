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
    gameOverSprite = new FlxSprite();
    gameOverSprite.loadGraphic("assets/images/gameOver.png");
    add(gameOverSprite);
  }

  public override function update(elapsed:Float):Void {
    if (FlxG.keys.justPressed.Q) {
      FlxG.switchState(new PlayState());
    }
    super.update(elapsed);
  }
}
