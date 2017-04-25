package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.addons.display.shapes.FlxShapeBox;

class HUDBar extends FlxSpriteGroup {
  var barBackground:FlxSprite;
  var bar:FlxSprite;
  var border:FlxShapeBox;
  var currentValue:Float;
  var barColor:Int;

  public var value(get, set):Float;

  function get_value():Float{
    return currentValue;
  }

  function set_value(v:Float):Float {
    var w:Int = Std.int((barBackground.width - 8) * v/100);
    if (w > 0) {
      bar.visible = true;
      bar.makeGraphic(w, Std.int(bar.height), barColor);
    } else if (w <= 0) {
      bar.visible = false;
    }

    currentValue = v;
    return currentValue;
  }

  public function new(width:Int, height:Int, barColor:Int, backgroundColor:Int = 0xff07102b):Void {
    super();
    this.barColor = barColor;

    barBackground = new FlxSprite();
    barBackground.makeGraphic(width, height, backgroundColor);
    add(barBackground);

    bar = new FlxSprite(barBackground.x + 2, barBackground.y + 2);
    bar.makeGraphic(width - 4, height - 4, barColor);
    add(bar);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
