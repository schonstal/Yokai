package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class TenguEnemy extends Enemy
{
  private var sinAmt:Float = 0;
  private var sinOffset:Float = 0;
  private var sinMod:Float = 0;

  public function new(X:Float=0,Y:Float=0) {
    super();
    x = X;
    y = Y;
    loadGraphic("assets/images/enemies/tengu.png");//, true, 50, 50);
    //animation.add("fly", [0], 15, true);
    //animation.play("fly");

    width = 6;
    height = 12;

    offset.y = 5;
    offset.x = 6;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public override function hurt(damage:Float):Void {
    super.hurt(damage);
  }

  public function init():Void {
    health = 30;
    sinAmt = 0;
    sinOffset = 0;
    sinMod = 0;
    //animation.play("fly");
    exists = true;
    alive = true;
  }

  override public function update(elapsed:Float):Void {
    sinAmt += elapsed;
    sinOffset = Math.sin(sinAmt + sinMod) * 30;

    velocity.x = sinOffset;

    if(velocity.x > 0) {
      facing = FlxObject.RIGHT;
    } else {
      facing = FlxObject.LEFT;
    }

    super.update(elapsed);
  }
}
