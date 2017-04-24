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

class Player extends Enemy
{
  inline static var ATTACK_DISPLACEMENT:Float = 25;
  inline static var UPPERCUT_DISPLACEMENT:Float = 150;
  inline static var RUN_SPEED:Float = 200;

  public static var gravity:Float = 200;

  public var justHurt:Bool = false;

  public var attackSprite:AttackSprite;

  public var stamina:Float = 100;

  var speed:Point;
  var terminalVelocity:Float = 150;

  var attackPressed:Bool = false;
  var shouldUppercut:Bool = false;
  var attackAmount:Float = 200;
  var attackTimer:Float = 0;
  var attackThreshold:Float = 0.125;

  var elapsed:Float = 0;
  var combo:Bool = false;
  var lastAttack:String = "attackOne";

  public function new(X:Float=0,Y:Float=0) {
    super();
    x = X;
    y = Y;
    loadGraphic("assets/images/player/player.png", true, 32, 32);

    animation.add("fall", [0], 15, true);
    animation.add("attackOne", [5, 6, 7, 8, 9], 20, false);
    animation.add("attackTwo", [10, 11, 12, 13, 13, 14], 20, false);
    animation.add("uppercut", [15], 20, false);
    animation.play("fall");

    width = 12;
    height = 18;

    offset.y = 9;
    offset.x = 11;

    speed = new Point();
    speed.y = attackAmount;
    speed.x = 800;
    solid = false;

    maxVelocity.x = RUN_SPEED;

    attackSprite = new AttackSprite();

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function init():Void {
    Reg.player = this;
    attackPressed = false;

    attackTimer = 0;

    velocity.x = velocity.y = 0;
    acceleration.x = 0;

    facing = FlxObject.RIGHT;
    acceleration.y = 0;
    Reg.started = false;
    health = 100;

    x = FlxG.width/2 - width/2;
    y = 80;
  }

  private function start():Void {
    acceleration.y = gravity;
    solid = true;
    alive = true;
    Reg.started = true;
  }

  public override function hurt(damage:Float):Void {
    if (justHurt && damage < 100) return;

    FlxG.camera.shake(0.005, 0.2);
    Reg.combo = 0;

    justHurt = true;
    FlxSpriteUtil.flicker(this, 0.6, 0.04, true, true, function(flicker) {
      justHurt = false;
    });

    super.hurt(damage);
  }

  private function isAttackPressed():Bool {
    //Check for attack input, allow for early timing
    attackTimer += elapsed;
    if (justPressed("attack")) {
      attackPressed = true;
      if (pressed("up")) {
        shouldUppercut = true;
      }
      attackTimer = 0;
      if (attackSprite.isAttacking) {
        combo = true;
      } else {
        combo = false;
      }
    }
    if (attackTimer > attackThreshold) {
      shouldUppercut = false;
      attackPressed = false;
    }

    return attackPressed;
  }

  private function attack(attackName):Void {
    var attackAnimation = attackSprite.animation.getByName(attackName);
    var duration = attackAnimation.delay * attackAnimation.numFrames;

    var tweenParams:Dynamic;
    if (shouldUppercut) {
      FlxTween.tween(
        this,
        { y: y - UPPERCUT_DISPLACEMENT },
        duration,
        { ease: FlxEase.quartOut }
      );
    }
    FlxTween.tween(
      this,
      { x: (facing == FlxObject.LEFT ? x - ATTACK_DISPLACEMENT : x + ATTACK_DISPLACEMENT) },
      duration,
      { ease: FlxEase.quartOut }
    );

    animation.play(attackName, true);

    attackSprite.facing = facing;
    attackSprite.attack(attackName);
  }

  private function tryAttacking():Void {
    if (!isAttackPressed() || attackSprite.isAttacking) {
      return;
    }

    var attackName:String = shouldUppercut ? "uppercut" : "attackOne";
    if (combo && !shouldUppercut) {
      attackName = (lastAttack == "attackOne" ? "attackTwo" : "attackOne");
    }

    attack(attackName);
    lastAttack = attackName;

    attackPressed = false;
    shouldUppercut = false;
  }

  private function handleMovement():Void {
    if (attackSprite.isAttacking) {
      acceleration.y =
        velocity.y =
        acceleration.x =
        velocity.x = 0;
    } else {
      animation.play("fall");
      acceleration.y = gravity;

      if (pressed("left") && !attackSprite.isAttacking) {
        acceleration.x = -speed.x * (velocity.x > 0 ? 4 : 1);
        facing = FlxObject.LEFT;
        offset.x = 7;
      } else if (pressed("right") && !attackSprite.isAttacking) {
        acceleration.x = speed.x * (velocity.x < 0 ? 4 : 1);
        facing = FlxObject.RIGHT;
        offset.x = 11;
      } else if (Math.abs(velocity.x) < 10) {
        velocity.x = 0;
        acceleration.x = 0;
      } else if (velocity.x > 0) {
        acceleration.x = -speed.x * 2;
      } else if (velocity.x < 0) {
        acceleration.x = speed.x * 2;
      }
    }

    if (x < 0) x = 0;
    if (x > FlxG.width - width) x = FlxG.width - width;
    if (y > FlxG.height - height) y = FlxG.height - height;
  }

  private function computeTerminalVelocity():Void {
    if (velocity.y > terminalVelocity) {
      velocity.y = terminalVelocity;
    }
  }

  override public function update(elapsed:Float):Void {
    this.elapsed = elapsed;

    if (!Reg.started && (justPressed("left") || justPressed("right") || justPressed("attack"))) {
      start();
    }

    if (alive && Reg.started) {
      handleMovement();
      tryAttacking();
      computeTerminalVelocity();
    }

    super.update(elapsed);
  }

  public override function kill():Void {
    visible = false;
    alive = false;
    Reg.started = false;
    solid = false;
    exists = false;
    acceleration.y = acceleration.x = velocity.x = velocity.y = 0;
    Reg.enemyExplosionService.explode(x + width/2, y + height/2 + explosionOffset.y, 0, 0, true);
  }

  private function justPressed(action:String):Bool {
    if (action == "attack") {
      return FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.X || justPressed("up");
    }
    if (action == "left") {
      return FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A;
    }
    if (action == "right") {
      return FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D;
    }
    if (action == "up") {
      return FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W;
    }
    if (action == "direction") {
      return justPressed("left") || justPressed("right");
    }
    return false;
  }

  private function pressed(action:String):Bool {
    if (action == "attack") {
      return FlxG.keys.pressed.SPACE || FlxG.keys.pressed.X || pressed("up");
    }
    if (action == "left") {
      return FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A;
    }
    if (action == "right") {
      return FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D;
    }
    if (action == "up") {
      return FlxG.keys.pressed.UP || FlxG.keys.pressed.W;
    }
    if (action == "direction") {
      return pressed("left") || pressed("right");
    }
    return false;
  }
}
