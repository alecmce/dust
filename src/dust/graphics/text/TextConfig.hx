package dust.graphics.text;

import dust.context.Config;
import dust.context.DependentConfig;
import dust.graphics.text.control.Fonts;
import dust.graphics.text.control.FontFactory;
import dust.graphics.text.control.TextFactory;
import dust.graphics.text.control.CharFactory;
import dust.graphics.colorAndTexture.ColorAndTextureRendererConfig;
import dust.Injector;

import snake.offsets.OffsetPositionConfig;

class TextConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
    {
        return [ColorAndTextureRendererConfig, OffsetPositionConfig];
    }

    public function configure()
    {
        injector.mapSingleton(CharFactory);
        injector.mapSingleton(TextFactory);
        injector.mapSingleton(FontFactory);
        injector.mapSingleton(Fonts);
    }
}
