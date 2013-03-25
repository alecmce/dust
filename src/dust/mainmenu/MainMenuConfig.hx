package dust.mainmenu;

import dust.text.Helvetica10WhiteFontConfig;
import dust.mainmenu.control.MainMenuButtonFactory;
import dust.graphics.data.Paint;
import dust.text.Michroma24WhiteFontConfig;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFonts;
import dust.mainmenu.data.MainMenuButtonConfig;
import dust.text.BitmapTextConfig;
import dust.signals.SignalMap;
import dust.mainmenu.MainMenu;
import minject.Injector;
import dust.app.SignalMapConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class MainMenuConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var signalMap:SignalMap;
    @inject public var fonts:BitmapFonts;

    public function dependencies():Array<Class<Config>>
        return [SignalMapConfig, Helvetica10WhiteFontConfig]

    public function configure()
    {
        injector.mapValue(MainMenuButtonConfig, makeConfig());
        injector.mapSingleton(MainMenuButtonFactory);
        injector.mapSingleton(MainMenu);
    }

        function makeConfig():MainMenuButtonConfig
        {
            var font = fonts.get(Helvetica10WhiteFontConfig.HELVETICA_10_WHITE);
            var paint = new Paint()
                .setFill(0x1E90FF)
                .setLine(1, 0xFFFFFF);

            return new MainMenuButtonConfig(font, paint, 80, 20);
        }
}
