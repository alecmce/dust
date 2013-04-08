package dust.text.data;

import nme.display.BitmapData;

class BitmapTextChar
{
    var char:BitmapFontChar;
    var x:Int;
    var y:Int;

    public function new(char:BitmapFontChar, x:Int, y:Int)
    {
        this.char = char;
        this.x = x;
        this.y = y;
    }

    inline public function drawTo(target:BitmapData, dx:Float = 0, dy:Float = 0)
        char.drawTo(target, x + dx, y + dy)
}
