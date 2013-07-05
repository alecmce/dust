package dust.text;

import flash.errors.Error;
import flash.display.BitmapData;
import openfl.Assets;
import dust.text.data.BitmapFont;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFonts;
import dust.context.Config;
import dust.context.DependentConfig;

class Fixed24WhiteMichromaFontConfig implements DependentConfig
{
    public static var FONT = '24-white-michroma';

    @inject public var factory:BitmapFontFactory;
    @inject public var fonts:BitmapFonts;

    public function dependencies():Array<Class<Config>>
        return [BitmapTextConfig];

    public function configure()
        fonts.add(FONT, makeFont());

        function makeFont():BitmapFont
        {
            var definition = Assets.getText('assets/michroma-24-white.fnt');
            if (definition == null)
                definition = '';

            var bitmapData = Assets.getBitmapData('assets/michroma-24-white.png');
            if (bitmapData == null)
                bitmapData = new BitmapData(1, 1, true, 0);

            return factory.make(definition, [bitmapData]);
        }
}
