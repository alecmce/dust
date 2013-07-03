package dust.inspector.control;

import dust.inspector.ui.UIFieldLabel;
import dust.text.control.BitmapFonts;
import dust.gui.control.UILabelledSliderFactory;
import dust.inspector.ui.UIFieldSlider;
import dust.gui.data.UISliderData;
import dust.gui.control.UISliderFactory;
import dust.gui.ui.UILabelledSlider;
import flash.display.Sprite;
import dust.gui.data.VAlign;
import dust.gui.control.UILabelFactory;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.control.BitmapTextDataFactory;
import dust.gui.data.Color;
import dust.gui.ui.UILabel;
import dust.gui.control.UILabelFactory;
import dust.inspector.data.InspectedField;
import dust.inspector.ui.UIInspectedField;

class UIInspectedFieldFactory
{
    static var LABEL_VALUE_HEIGHT = 12;
    static var FONT = SmallWhiteHelveticaFontConfig.FONT;

    @inject public var dataFactory:BitmapTextDataFactory;
    @inject public var labelFactory:UILabelFactory;
    @inject public var fonts:BitmapFonts;
    @inject public var sliderFactory:UILabelledSliderFactory;

    public function make(field:InspectedField, maxWidth:Int):Sprite
    {
//        return cast if (isNumeric(field))
            return makeSlider(field, maxWidth);
//        else
//            makeLabel(field, maxWidth);
    }

        function isNumeric(field:InspectedField)
            return Std.is(field.value, Float) || Std.is(field.value, Int)

        function makeSlider(field:InspectedField, maxWidth:Int)
        {
            var slider = new UIFieldSlider(field);
            var data = new UISliderData(slider.updateValue, 5, 0, 10).setWidth(maxWidth);
            var font = fonts.get(FONT);

            var inner = sliderFactory.make(data, font, field.toString());
            inner.enable();

            return slider.setSlider(inner);
        }

        function makeLabel(field:InspectedField, maxWidth:Int):UIInspectedField
        {
            return new UIFieldLabel(field)
                .setNameLabel(makeNameLabel(field, maxWidth))
                .setDisplayLabel(makeValueLabel(maxWidth));
        }

            function makeNameLabel(field:InspectedField, maxWidth:Int):UILabel
            {
                var data = dataFactory.make(FONT, field.toString());
                data.width = maxWidth;
                data.height = LABEL_VALUE_HEIGHT;
                data.vAlign = VAlign.BOTTOM;
                return labelFactory.make(data);
            }

            function makeValueLabel(maxWidth:Int):UILabel
            {
                var data = dataFactory.make(FONT, '??');
                data.width = maxWidth;
                data.background = 0xFF333333;
                return labelFactory.make(data);
            }
}
