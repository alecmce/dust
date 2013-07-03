package dust.text.data;

import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import flash.display.BitmapData;
import flash.geom.Rectangle;

class BitmapTextChars
{
    var chars:Array<BitmapTextChar>;
    public var bounds:Rectangle;

    public function new(chars:Array<BitmapTextChar>, bounds:Rectangle)
    {
        this.chars = chars;
        this.bounds = bounds;
    }

    public function draw(bitmapData:BitmapData, hAlign:HAlign = null, vAlign:VAlign = null)
    {
        var dx = calculateDX(hAlign, bitmapData.width);
        var dy = calculateDY(vAlign, bitmapData.height);

        for (char in chars)
            char.drawTo(bitmapData, dx, dy);
    }

        function calculateDX(hAlign:HAlign, width:Int):Float
        {
            return if (hAlign == HAlign.CENTER)
                (width - bounds.width)  * 0.5;
            else if (hAlign == HAlign.RIGHT)
                width - bounds.width;
            else
                0;
        }

        function calculateDY(vAlign:VAlign, height:Int):Float
        {
            return if (vAlign == VAlign.MIDDLE)
                (height - bounds.height) * 0.5 - bounds.top;
            else if (vAlign == VAlign.BOTTOM)
                height - bounds.height - bounds.top;
            else
                -bounds.top;
        }
}
