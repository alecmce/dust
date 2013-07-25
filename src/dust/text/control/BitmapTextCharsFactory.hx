package dust.text.control;

import dust.text.data.BitmapTextChars;
import dust.text.data.BitmapTextChar;
import flash.geom.Rectangle;
import dust.text.data.BitmapFont;

class BitmapTextCharsFactory
{
    public function make(font:BitmapFont, label:String):BitmapTextChars
    {
        var x = 0;
        var y = 0;
        var bounds = new Rectangle(0, font.lineHeight, 0, 0);

        var textChars = new Array<BitmapTextChar>();
        for (i in 0...label.length)
        {
            var fontChar = font.getChar(label.charCodeAt(i));
            if (fontChar == null)
                continue;

            var textChar = new BitmapTextChar(fontChar, x, y);
            x += fontChar.advance;
            textChars.push(textChar);

            var top = y + fontChar.dy;
            if (bounds.top > top)
                bounds.top = top;

            var right = x + fontChar.dx;
            if (bounds.right < right)
                bounds.right = right;

            var bottom = y + fontChar.dy + fontChar.data.height;
            if (bounds.bottom < bottom)
                bounds.bottom = bottom;
        }

        return new BitmapTextChars(textChars, bounds);
    }
}
