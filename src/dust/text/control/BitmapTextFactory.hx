package dust.text.control;

import dust.text.data.BitmapFont;
import dust.text.data.BitmapFontChar;
import dust.text.data.BitmapFont;
import dust.text.data.BitmapFont;

import nme.geom.Point;
import nme.display.BitmapData;
import nme.geom.Rectangle;

class BitmapTextFactory
{
    var position:Point;

    public function new()
        position = new Point()

    public function make(font:BitmapFont, label:String):BitmapData
    {
        var chars = makeChars(font, label);
        var bitmapData = makeBitmapData(chars.bounds);
        for (char in chars.list)
            char.drawTo(bitmapData);

        return bitmapData;
    }

        function makeChars(font:BitmapFont, label:String):{list:Array<BitmapTextChar>, bounds:Rectangle}
        {
            var x = 0;
            var y = 0;
            var bounds = new Rectangle(0, 0, 0, font.lineHeight);

            var textChars = new Array<BitmapTextChar>();
            for (i in 0...label.length)
            {
                var fontChar = font.getChar(label.charCodeAt(i));
                if (fontChar == null)
                    continue;

                var textChar = new BitmapTextChar(fontChar, x, y);
                x += fontChar.advance;
                textChars.push(textChar);

                var right = x + fontChar.dx + fontChar.data.width;
                if (bounds.right < right)
                    bounds.right = right;

                var bottom = y + fontChar.dy + fontChar.data.height;
                if (bounds.bottom < bottom)
                    bounds.bottom = bottom;
            }

            return {list:textChars, bounds:bounds};
        }

        function makeBitmapData(bounds:Rectangle):BitmapData
        {
            var width = Std.int(bounds.width);
            var height = Std.int(bounds.height);
            return new BitmapData(width, height, true, 0);
        }
}

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

    inline public function drawTo(target:BitmapData)
        char.drawTo(target, x, y)

}
