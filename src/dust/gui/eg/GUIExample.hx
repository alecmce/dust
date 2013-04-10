package dust.gui.eg;

import dust.text.control.BitmapFonts;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.data.BitmapTextData;
import dust.gui.control.UILabelledSliderFactory;
import dust.gui.data.UISliderData;
import dust.gui.control.UISliderFactory;
import dust.gui.GUIConfig;
import dust.console.ConsoleConfig;
import dust.console.impl.Console;
import nme.display.DisplayObjectContainer;
import dust.gui.ui.UISlider;
import dust.context.Config;
import dust.context.DependentConfig;

class GUIExample implements DependentConfig
{
    @inject public var root:DisplayObjectContainer;
    @inject public var console:Console;
    @inject public var sliderFactory:UISliderFactory;
    @inject public var fonts:BitmapFonts;
    @inject public var labelledSliderFactory:UILabelledSliderFactory;


    public function dependencies():Array<Class<Config>>
        return [GUIConfig, ConsoleConfig]

    public function configure()
    {
        makeSlider();
        makeLabelledSlider();
    }

        function makeSlider()
        {
            var data = new UISliderData(onUpdate, 50, 0, 200);

            var slider = sliderFactory.make(data);
            slider.x = 200;
            slider.y = 200;
            slider.enable();
            root.addChild(slider);
        }

        function makeLabelledSlider()
        {
            var data = new UISliderData(onUpdate, 50, 0, 200);
            var font = fonts.get(SmallWhiteHelveticaFontConfig.FONT);

            var slider = labelledSliderFactory.make(data, font, 'labelled slider');
            slider.x = 200;
            slider.y = 250;
            slider.enable();
            root.addChild(slider);
        }

        function onUpdate(value:Float)
            console.write('slider.value = ' + value)
}
