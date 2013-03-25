package dust.text;

import nme.errors.Error;
import nme.display.BitmapData;
import nme.Assets;
import dust.text.data.BitmapFont;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFonts;
import dust.context.Config;
import dust.context.DependentConfig;

class Michroma24WhiteFontConfig implements DependentConfig
{
    public static var MICHROMA_24_WHITE = 'michroma-24-white';

    @inject public var factory:BitmapFontFactory;
    @inject public var fonts:BitmapFonts;

    public function dependencies():Array<Class<Config>>
        return [BitmapTextConfig]

    public function configure()
        fonts.add(MICHROMA_24_WHITE, makeFont())

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
