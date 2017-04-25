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
    var width:Int = Std.int((barBackground.width - 8) * v/100);
    if (v != currentValue && width > 0) {
      bar.makeGraphic(width, Std.int(bar.height), barColor);
      bar.x = barBackground.x + barBackground.width - 2 - bar.width;
    } else if (width <= 0) {
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
