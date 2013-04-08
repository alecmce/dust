package dust.text.data;

import nme.geom.Point;
import nme.display.BitmapData;

class BitmapFontChar
{
    static var position:Point = new Point();

    public var id:Int;
    public var data:BitmapData;
    public var dx:Int;
    public var dy:Int;
    public var advance:Int;

    var kerning:IntHash<Int>;

    public function new()
        kerning = new IntHash<Int>()

    public function addKerning(char:Int, amount:Int)
        kerning.set(char, amount)

    public function getKerning(char:Int):Int
        return kerning.exists(char) ? kerning.get(char) : 0

    public function drawTo(target:BitmapData, x:Float, y:Float)
    {
        position.x = x + dx;
        position.y = y + dy;
        target.copyPixels(data, data.rect, position, null, null, true);
    }


    public function toString():String
        return ['[BitmapFontChar id=',id,' dx=',dx,' dy=',dy,' advance=',advance,']'].join('')
}
