package dust.text;

import dust.app.data.AppTarget;
import dust.app.data.App;
import dust.app.AppConfig;
import flash.errors.Error;
import flash.display.BitmapData;
import openfl.Assets;
import dust.text.data.BitmapFont;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFonts;
import dust.context.Config;
import dust.context.DependentConfig;

class SmallWhiteHelveticaFontConfig implements DependentConfig
{
    public static var FONT = 'small-white-helvetica';

    static var FONT_10 = 'helvetica-10-white';
    static var FONT_20 = 'helvetica-20-white';

    @inject public var app:App;
    @inject public var factory:BitmapFontFactory;
    @inject public var fonts:BitmapFonts;

    public function dependencies():Array<Class<Config>>
        return [AppConfig, BitmapTextConfig];

    public function configure()
        fonts.add(FONT, makeFont());

        function makeFont():BitmapFont
        {
            var definition = getFontDefinition();
            if (definition == null)
                definition = '';

            var bitmapData = getFontAsset();
            if (bitmapData == null)
                bitmapData = new BitmapData(1, 1, true, 0);

            return factory.make(definition, [bitmapData]);
        }

            function getFontDefinition():String
                return Assets.getText('assets/' + getFontTarget() + '.fnt');

            function getFontAsset():BitmapData
                return Assets.getBitmapData('assets/' + getFontTarget() + '.png');

            function getFontTarget()
            {
                return switch(app.target)
                {
                    case AppTarget.IPAD_RETINA:
                        FONT_20;
                    default:
                        FONT_10;
                }
            }
}
