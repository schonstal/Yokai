package;
import flixel.FlxG;

class SpawnService {
  private var spawnAhead:Float = 50;
  private var probability:Float = 0.005;
  private var minDistance:Float = 25;
  private var maxDistance:Float = 100;

  private var lastPlacedAt:Float = 0;

  private var previousY:Float;

  public var tenguGroup:TenguGroup;

  public function new(tenguGroup:TenguGroup):Void {
    this.tenguGroup = tenguGroup;
  }

  public function trySpawning():Void {
    var topY = FlxG.camera.scroll.y - spawnAhead;

    if(topY < previousY) {
      var distance = -(topY - lastPlacedAt);
      var shouldPlace = Reg.random.float(0, 1) < probability || (distance >= maxDistance);

      if(distance > minDistance && shouldPlace) {
        lastPlacedAt = topY;
        spawnEnemy(topY);
      }
    }

    previousY = FlxG.camera.scroll.y;
  }

  private function spawnEnemy(y:Float):Void {
    tenguGroup.spawn(Reg.random.float(0, FlxG.width - 30), y);
  }
}
