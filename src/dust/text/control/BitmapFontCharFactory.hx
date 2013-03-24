package dust.text.control;

import nme.geom.Rectangle;
import nme.geom.Point;
import nme.display.BitmapData;
import dust.text.data.BitmapFontChar;

class BitmapFontCharFactory
{
    private var origin:Point;
    private var rect:Rectangle;

    public function new()
    {
        origin = new Point();
        rect = new Rectangle();
    }

    public function make(hash:Hash<Dynamic>, sources:Array<BitmapData>):BitmapFontChar
    {
        var page = hash.get('page');
        var source = sources[page];

        var char:BitmapFontChar = new BitmapFontChar();
        char.data = makeData(hash, source);
        char.dx = hash.get('xoffset');
        char.dy = hash.get('yoffset');
        char.xAdvance = hash.get('xadvance');
        return char;
    }

        function makeHash(line:String):Hash<Dynamic>
        {
            var hash = new Hash<Dynamic>();

            var pairs = line.split(" ");
            for (pair in pairs)
            {
                var keyvalue = pair.split("=");
                if (keyvalue.length > 1)
                    hash.set(keyvalue[0], keyvalue[1]);
            }

            return hash;
        }

        function makeData(hash:Hash<Dynamic>, source:BitmapData):BitmapData
        {
            var width = hash.get('width');
            var height = hash.get('height');
            var data = new BitmapData(width, height, true, 0);

            rect.x = hash.get('x');
            rect.y = hash.get('y');
            rect.width = width;
            rect.height = height;
            data.copyPixels(source, rect, origin, null, null, false);
            return data;
        }
}
