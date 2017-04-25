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
    loadGraphic("assets/images/enemies/tengu.png", true, 48, 48);

    animation.add("fly", [0, 1, 1, 2, 2, 3, 4, 5], 10, true);
    animation.play("fly");

    width = 26;
    height = 26;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

    explosionOffset.y = -width/2;
    explosionOffset.x = -height/2;
    explosionCount = 4;
    deathHeight = height;
    deathWidth = width;

    onDeath = function() {
      Reg.player.stamina += 50;
      if (Reg.player.stamina > 100) {
        Reg.player.stamina = 100;
      }
    }
  }

  public override function hurt(damage:Float):Void {
    super.hurt(damage);
  }

  public function init():Void {
    health = 50;
    sinAmt = 0;
    sinOffset = 0;
    sinMod = 0;
    animation.play("fly");
    exists = true;
    alive = true;

    facing = FlxObject.RIGHT;
    offset.y = 15;
    offset.x = 10;
  }

  override public function update(elapsed:Float):Void {
    sinAmt += elapsed * 2;
    sinOffset = Math.sin(sinAmt + sinMod) * 20;

    velocity.y = sinOffset;

    if(velocity.y > 0) {
      facing = FlxObject.RIGHT;
      offset.y = 10;
    } else {
      facing = FlxObject.LEFT;
      offset.y = 11;
    }

    super.update(elapsed);
  }
}
