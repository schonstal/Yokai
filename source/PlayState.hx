package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;
import flixel.addons.display.FlxStarField.FlxStarField2D;

class PlayState extends FlxState {
  var playerProjectileGroup:FlxSpriteGroup;
  var enemyProjectileGroup:FlxSpriteGroup;
  var enemyGroup:FlxSpriteGroup;
  var enemyExplosionGroup:FlxSpriteGroup;

  var pointGroup:FlxSpriteGroup;
  var gameOverGroup:GameOverGroup;

  var player:Player;

  var level:Room;
  var hud:HUD;

  var gameOver:Bool = false;

  override public function create():Void {
    super.create();
    FlxG.timeScale = 1;

    Reg.random = new FlxRandom();
    Reg.difficulty = 0;
    Reg.score = 0;

    initializeServices();

    enemyGroup = new FlxSpriteGroup();
    var e = new BatEnemy(100, 100);
    enemyGroup.add(e);
    var s = new ShootingEnemy(20, 200);
    enemyGroup.add(s);

    var background = new FlxSprite();
    background.loadGraphic("assets/images/background/walls.png");
    background.y = FlxG.height - background.height;

    var starField:FlxStarField2D = new FlxStarField2D(0, Std.int(background.y), FlxG.width, Std.int(background.height), 100);
    starField.setStarSpeed(1, 80);
    add(starField);

    add(background);

    player = new Player();
    hud = new HUD();
    gameOverGroup = new GameOverGroup();

    player.init();


    add(player);
    add(player.attackSprite);
    add(enemyGroup);
    add(playerProjectileGroup);
    add(enemyProjectileGroup);
    add(enemyExplosionGroup);
    add(pointGroup);
    add(hud);
    add(gameOverGroup);

    FlxG.debugger.drawDebug = true;
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    checkPlayerDeath();

    super.update(elapsed);

    collideEnemiesWithProjectiles();
    collidePlayerWithProjectiles();

    recordHighScores();

    if (FlxG.camera.scroll.y > player.y) {
      FlxG.camera.scroll.y = player.y;
    }
  }

  private function initializeServices() {
    enemyExplosionGroup = new FlxSpriteGroup();
    Reg.enemyExplosionService = new EnemyExplosionService(enemyExplosionGroup);

    playerProjectileGroup = new FlxSpriteGroup();
    Reg.playerProjectileService = new ProjectileService(playerProjectileGroup);

    enemyProjectileGroup = new FlxSpriteGroup();
    Reg.enemyProjectileService = new ProjectileService(enemyProjectileGroup);

    pointGroup = new FlxSpriteGroup();
    Reg.pointService = new PointService(pointGroup);
  }

  private function checkPlayerDeath() {
    if (player.alive == false) {
      if (!gameOver) {
        FlxG.save.flush();
        FlxG.sound.music.stop();
        FlxG.timeScale = 0.2;
        new FlxTimer().start(0.1, function(t) {
          gameOverGroup.exists = true;
          hud.exists = false;
          FlxTween.tween(FlxG, { timeScale: 1 }, 0.5, { ease: FlxEase.quartOut, onComplete: function(t) {
            FlxG.timeScale = 1;
          }});
        });
      }
      gameOver = true;
    }
  }

  private function collideEnemiesWithProjectiles() {
    FlxG.overlap(enemyGroup, player.attackSprite, function(enemy:FlxObject, attackSprite:FlxObject):Void {
      player.attackSprite.collideWith(enemy);
    });

    FlxG.overlap(enemyGroup, enemyProjectileGroup, function(enemy:FlxObject, projectile:FlxObject):Void {
      var p = cast(projectile, Projectile);
      if (!p.reflected) return;

      enemy.hurt(50);
      player.attackSprite.onLandHit();
    });
  }

  private function collidePlayerWithProjectiles() {
    FlxG.overlap(enemyProjectileGroup, player.attackSprite, function(projectile:FlxObject, attackSprite:FlxObject):Void {
      var p = cast(projectile, Projectile);
      if (p.reflected) return;

      p.reflect(player.facing);
      player.attackSprite.onLandHit();
    });

    FlxG.overlap(player, enemyProjectileGroup, function(player:FlxObject, projectile:FlxObject):Void {
      if (!cast(projectile, Projectile).isDangerous()) return;
      if (cast(player, Player).justHurt) return;
      player.hurt(25);
    });
  }

  private function recordHighScores():Void {
    if (FlxG.save.data.highScore == null) {
      FlxG.save.data.highScore = 0;
    }
    if (Reg.score > FlxG.save.data.highScore) {
      FlxG.save.data.highScore = Reg.score;
    }
  }
}
