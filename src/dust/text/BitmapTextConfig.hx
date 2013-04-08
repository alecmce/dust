package dust.text;

import dust.text.control.BitmapTextCharsFactory;
import dust.text.control.BitmapTextDataFactory;
import dust.text.control.BitmapFonts;
import dust.text.control.BitmapTextFactory;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFontCharFactory;
import dust.context.Config;

import dust.Injector;

class BitmapTextConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(BitmapFontCharFactory);
        injector.mapSingleton(BitmapTextDataFactory);
        injector.mapSingleton(BitmapTextCharsFactory);
        injector.mapSingleton(BitmapFontFactory);
        injector.mapSingleton(BitmapTextFactory);
        injector.mapSingleton(BitmapFonts);
    }
}
