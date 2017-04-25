package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class PointService {
  var points:Array<PointText> = new Array<PointText>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.points = new Array<PointText>();
    this.group = group;
  }

  public function showPoints(X:Float, Y:Float, amount:Int, color:Int):PointText {
    var point = recycle(X, Y, amount, color);
    group.add(point);

    return point;
  }

  function recycle(X:Float, Y:Float, amount:Int, color:Int):PointText {
    for(p in points) {
      if(!p.exists) {
        p.initialize(X, Y, amount, color);
        return p;
      }
    }

    var point:PointText = new PointText(X, Y, amount, color);
    points.push(point);

    return point;
  }
}
