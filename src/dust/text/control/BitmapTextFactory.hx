package dust.text.control;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.display.BitmapData;
import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.text.data.BitmapTextData;
import dust.text.data.BitmapFont;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Rectangle;

class BitmapTextFactory
{
    @inject public var charsFactory:BitmapTextCharsFactory;

    var position:Point;
    var width:Int;
    var height:Int;

    public function new()
    {
        position = new Point();
    }

    public function make(data:BitmapTextData, current:BitmapData = null):BitmapData
    {
        var chars = charsFactory.make(data.font, data.label);
        defineBounds(data, chars.bounds);
        var target = getBitmapData(current, data);
        chars.draw(target, data.hAlign, data.vAlign);
        return target;
    }

        function defineBounds(data:BitmapTextData, bounds:Rectangle)
        {
            width = data.width != BitmapTextData.UNDEFINED ? data.width : Std.int(bounds.width);
            height = data.height != BitmapTextData.UNDEFINED ? data.height : Std.int(bounds.height);
        }

        function getBitmapData(current:BitmapData, data:BitmapTextData):BitmapData
        {
            return if (current != null)
                reuseOrReplaceCurrentBitmapData(current, data);
            else if (width == 0 || height == 0)
                new BitmapData(1, 1, true, 0);
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
            {
                return new BitmapData(width, height, data.useAlpha, data.background);
            }
}