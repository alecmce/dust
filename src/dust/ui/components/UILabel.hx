package dust.ui.components;

import dust.text.data.BitmapTextData;
import dust.text.data.BitmapFont;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.control.BitmapTextFactory;
import dust.text.control.BitmapTextFactory;
import nme.display.Bitmap;
import nme.display.BitmapData;
import dust.ui.data.Color;
import nme.Assets;
import nme.display.Sprite;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

class UILabel extends Bitmap
{
    var factory:BitmapTextFactory;
    var data:BitmapTextData;

    var bitmap:BitmapData;

    public function new(factory:BitmapTextFactory, data:BitmapTextData)
    {
        this.factory = factory;
        this.data = data;
        super(factory.make(data));
    }

    public function setLabel(label:String):UILabel
    {
        if (data.label != label)
        {
            data.label = label;
            update();
        }
        return this;
    }

    public function setWidth(width:Int):UILabel
    {
        if (data.width != width)
        {
            data.width = width;
            update();
        }
        return this;
    }

    public function setBackground(background:Int):UILabel
    {
        if (data.background != background)
        {
            data.background = background;
            update();
        }
        return this;
    }

        function update()
            bitmapData = factory.make(data, bitmapData)

    public function getWidth():Int
        return data.width
}