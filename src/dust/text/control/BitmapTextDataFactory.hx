package dust.text.control;

import dust.text.data.BitmapTextData;
import dust.text.control.BitmapFontFactory.BitmapFontData;

class BitmapTextDataFactory
{
    static var DEFAULT_FONT = SmallWhiteHelveticaFontConfig.FONT;

    @inject public var fonts:BitmapFonts;

    public function new() {}

    public function make(font:String, label:String):BitmapTextData
        return new BitmapTextData(fonts.get(font), label)

    public function makeWithDefaults(label:String):BitmapTextData
        return new BitmapTextData(fonts.get(DEFAULT_FONT), label)
}
