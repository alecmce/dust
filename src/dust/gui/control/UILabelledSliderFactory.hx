package dust.gui.control;

import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.gui.data.UISliderData;
import dust.text.control.BitmapFontFactory.BitmapFontData;
import dust.text.data.BitmapFont;
import dust.text.data.BitmapTextData;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.gui.data.UISliderData;
import dust.text.control.BitmapTextDataFactory;
import dust.gui.control.UISliderFactory;
import dust.gui.ui.UILabelledSlider;
import dust.gui.ui.UILabel;
import dust.gui.ui.UISlider;

class UILabelledSliderFactory
{
    @inject public var dataFactory:BitmapTextDataFactory;
    @inject public var sliderFactory:UISliderFactory;
    @inject public var labelFactory:UILabelFactory;

    public function make(sliderData:UISliderData, font:BitmapFont, label:String):UILabelledSlider
    {
        var labelData = makeLabelData(sliderData, font, label);

        return new UILabelledSlider()
            .setSlider(sliderFactory.make(sliderData))
            .setLabel(labelFactory.make(labelData));
    }

        function makeLabelData(sliderData:UISliderData, font:BitmapFont, label:String):BitmapTextData
        {
            var data = new BitmapTextData(font, label);
            data.width = sliderData.width;
            data.height = sliderData.height;
            data.hAlign = HAlign.CENTER;
            data.vAlign = VAlign.MIDDLE;
            return data;
        }
}
