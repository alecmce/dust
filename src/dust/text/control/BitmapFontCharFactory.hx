package dust.text.control;

import flash.geom.Rectangle;
import flash.geom.Point;
import flash.display.BitmapData;
import dust.text.data.BitmapFontChar;

class BitmapFontCharFactory
{
    private var origin:Point;
    private var rect:Rectangle;
    private var pixel:BitmapData;

    public function new()
    {
        origin = new Point();
        rect = new Rectangle();
        pixel = new BitmapData(1, 1, true, 0);
    }

    public function make(hash:Map<String, Dynamic>, sources:Array<BitmapData>):BitmapFontChar
    {
        var page = hash.get('page');
        var source = sources[page];
        var char:BitmapFontChar = new BitmapFontChar();
        char.id = hash.get('id');
        char.data = makeData(hash, source);
        char.dx = hash.get('xoffset');
        char.dy = hash.get('yoffset');
        char.advance = hash.get('xadvance');
        return char;
    }

        function makeHash(line:String):Map<String, Dynamic>
        {
            var hash = new Map<String, Dynamic>();

            var pairs = line.split(" ");
            for (pair in pairs)
            {
                var keyvalue = pair.split("=");
                if (keyvalue.length > 1)
                    hash.set(keyvalue[0], keyvalue[1]);
            }

            return hash;
        }

        function makeData(hash:Map<String, Dynamic>, source:BitmapData):BitmapData
        {
            var width = hash.get('width');
            var height = hash.get('height');

            if (width <= 0 || height <= 0)
                return pixel;

            var x = hash.get('x');
            var y = hash.get('y');

            var data = new BitmapData(width, height, true, 0);
            rect.x = x;
            rect.y = y;
            rect.width = width;
            rect.height = height;
            data.copyPixels(source, rect, origin, null, null, true);
            return data;
        }
}
