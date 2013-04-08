package dust.text.control;

import nme.display.BitmapData;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import dust.text.data.BitmapTextChar;
import dust.ui.data.VAlign;
import dust.ui.data.HAlign;
import dust.text.data.BitmapTextData;
import dust.text.data.BitmapTextData;
import dust.ui.data.Color;
import dust.text.data.BitmapFont;
import dust.text.data.BitmapFontChar;
import dust.text.data.BitmapFont;
import dust.text.data.BitmapFont;

import nme.geom.Point;
import nme.display.BitmapData;
import nme.geom.Rectangle;

class BitmapTextFactory
{
    @inject public var charsFactory:BitmapTextCharsFactory;

    var position:Point;
    var width:Int;
    var height:Int;

    public function new()
        position = new Point()

    public function make(data:BitmapTextData, current:BitmapData = null):BitmapData
    {
        var chars = charsFactory.make(data.font, data.label);
        var bounds = getBounds(data, chars.bounds);
        var target = getBitmapData(current, data);
        chars.draw(target, data.hAlign, data.vAlign);
        return target;
    }

        function getBounds(data:BitmapTextData, bounds:Rectangle)
        {
            width = data.width != BitmapTextData.UNDEFINED ? data.width : Std.int(bounds.width);
            height = data.height != BitmapTextData.UNDEFINED ? data.height : Std.int(bounds.height);
        }

        function getBitmapData(current:BitmapData, data:BitmapTextData):BitmapData
        {
            return if (current != null)
                reuseOrReplaceCurrentBitmapData(current, data);
            else if (width == 0 || height == 0)
                null;
            else
                makeNewBitmapData(data);
        }

            inline function reuseOrReplaceCurrentBitmapData(current:BitmapData, data:BitmapTextData):BitmapData
            {
                return if (current.width < width || current.height < height)
                    replaceBitmapData(current, data);
                else
                    reuseBitmapData(current, data);
            }

                inline function replaceBitmapData(current:BitmapData, data:BitmapTextData):BitmapData
                {
                    current.dispose();
                    return makeNewBitmapData(data);
                }

                inline function reuseBitmapData(current:BitmapData, data:BitmapTextData):BitmapData
                {
                    current.fillRect(current.rect, data.background);
                    return current;
                }

            inline function makeNewBitmapData(data:BitmapTextData):BitmapData
                return new BitmapData(width, height, data.useAlpha, data.background)
}


