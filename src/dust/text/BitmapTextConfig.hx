package dust.text;

import dust.text.control.BitmapTextFactory;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFontCharFactory;
import dust.context.Config;

import minject.Injector;

class BitmapTextConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(BitmapFontCharFactory);
        injector.mapSingleton(BitmapFontFactory);
        injector.mapSingleton(BitmapTextFactory);
    }
}
