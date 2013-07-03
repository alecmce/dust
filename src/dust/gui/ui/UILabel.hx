package dust.gui.ui;

import dust.text.data.BitmapTextData;
import dust.text.data.BitmapFont;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.control.BitmapTextFactory;
import dust.text.control.BitmapTextFactory;
import flash.display.Bitmap;
import flash.display.BitmapData;
import dust.gui.data.Color;
import openfl.Assets;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

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
        return bitmapData.width
}