package dust.text.control;

import nme.geom.Point;
import dust.text.data.BitmapFontChar;
import dust.text.data.BitmapFont;
import nme.geom.Rectangle;
import dust.text.data.BitmapFont;

import nme.display.BitmapData;

class BitmapTextFactory
{
    var position:Point;

    public function new()
        position = new Point()

    public function make(font:BitmapFont, label:String):BitmapData
    {
        var chars = getChars(font, label);
        var bounds = getBounds(chars);
        var bitmapData = makeBitmapData(bounds);
        draw(bitmapData, chars, bounds);
        return bitmapData;
    }

    function getChars(font:BitmapFont, label:String):Array<Char>
    {
        var x = 0;
        var y = 0;

        var list = new Array<Char>();
        for (i in 0...label.length)
        {
            var char = font.getChar(label.charCodeAt(i));
            var bounds = new Rectangle(x + char.dx, y + char.dy, char.data.width, char.data.height);
            x += char.xAdvance;
            list.push({char:char, bounds:bounds});
        }

        return list;
    }

    function getBounds(chars:Array<Char>):Rectangle
    {
        var bounds = new Rectangle();
        for (char in chars)
            bounds = bounds.union(char.bounds);
        return bounds;
    }

    function makeBitmapData(bounds:Rectangle):BitmapData
    {
        var width = Std.int(bounds.width);
        var height = Std.int(bounds.height);
        return new BitmapData(width, height, true, 0);
    }

    function draw(bitmapData:BitmapData, chars:Array<Char>, bounds:Rectangle)
    {
        var dx = Std.int(bounds.left);
        var dy = Std.int(bounds.top);

        for (char in chars)
        {
            var data:BitmapData = char.char.data;
            position.setTo(position.x + dx, position.y + dy);
            bitmapData.copyPixels(data, data.rect, position, null, null, false);
        }
    }
}

typedef Char = {char:BitmapFontChar, bounds:Rectangle}
