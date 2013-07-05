package dust.gui.control;

import dust.text.control.BitmapTextDataFactory;
import dust.text.control.BitmapFontFactory.BitmapFontData;
import dust.text.data.BitmapTextData;
import dust.text.data.BitmapFont;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.control.BitmapFonts;
import dust.gui.ui.UILabel;
import dust.text.control.BitmapTextFactory;

class UILabelFactory
{
    @inject public var dataFactory:BitmapTextDataFactory;
    @inject public var textFactory:BitmapTextFactory;

    public function new() {}

    public function make(data:BitmapTextData):UILabel
        return new UILabel(textFactory, data);

    public function makeWithDefaults(label:String):UILabel
        return make(dataFactory.make(SmallWhiteHelveticaFontConfig.FONT, label));
}
