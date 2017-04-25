package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class GameOverGroup extends FlxSpriteGroup {
  var scoreText:FlxBitmapText;
  var highScoreText:FlxBitmapText;
  var gameOverSprite:FlxSprite;

  public function new():Void {
    super();

    exists = false;

    scrollFactor.x = scrollFactor.y = 0;

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    gameOverSprite = new FlxSprite();
    gameOverSprite.loadGraphic("assets/images/gameover.png");
    add(gameOverSprite);

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "0";
    scoreText.x = 132;
    scoreText.y = 120;
    add(scoreText);

    highScoreText = new FlxBitmapText(font);
    highScoreText.letterSpacing = -2;
    highScoreText.text = "0";
    highScoreText.x = 132;
    highScoreText.y = 149;
    add(highScoreText);
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;
    highScoreText.text = "" + FlxG.save.data.highScore;

    if (FlxG.keys.justPressed.SPACE) {
      FlxG.switchState(new PlayState());
    }

    super.update(elapsed);
  }
}
