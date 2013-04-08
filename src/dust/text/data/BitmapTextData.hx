package dust.text.data;

import dust.ui.data.VAlign;
import dust.ui.data.HAlign;

class BitmapTextData
{
    public static var UNDEFINED = -1;

    public var font:BitmapFont;
    public var label:String;

    public var useAlpha:Bool;
    public var background:Int;
    public var width:Int;
    public var height:Int;
    public var hAlign:HAlign;
    public var vAlign:VAlign;

    public function new(font:BitmapFont, label:String)
    {
        this.font = font;
        this.label = label;

        useAlpha = true;
        background = 0;
        width = UNDEFINED;
        height = UNDEFINED;
        hAlign = HAlign.LEFT;
        vAlign = VAlign.TOP;
    }
}
