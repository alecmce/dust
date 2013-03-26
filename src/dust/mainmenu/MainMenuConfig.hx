package dust.mainmenu;

import dust.app.data.AppTarget;
import nme.display.DisplayObjectContainer;
import dust.app.data.AppData;
import dust.app.AppConfig;
import dust.text.HelveticaSmallWhiteFontConfig;
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
import dust.signals.SignalMapConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class MainMenuConfig implements DependentConfig
{
    @inject public var app:AppData;
    @inject public var injector:Injector;
    @inject public var signalMap:SignalMap;
    @inject public var fonts:BitmapFonts;
    @inject public var root:DisplayObjectContainer;

    public function dependencies():Array<Class<Config>>
        return [AppConfig, SignalMapConfig, HelveticaSmallWhiteFontConfig]

    public function configure()
    {
        injector.mapValue(MainMenuButtonConfig, makeConfig());
        injector.mapSingleton(MainMenuButtonFactory);
        injector.mapSingleton(MainMenu);

        root.addChild(injector.getInstance(MainMenu));
    }

        function makeConfig():MainMenuButtonConfig
        {
            var font = fonts.get(HelveticaSmallWhiteFontConfig.FONT);
            var paint = new Paint()
                .setFill(0x1E90FF)
                .setLine(1, 0xFFFFFF);

            return switch (app.target)
            {
                case AppTarget.IPAD_RETINA:
                    new MainMenuButtonConfig(app, font, paint, 320, 80, 40);
                default:
                    new MainMenuButtonConfig(app, font, paint, 160, 40, 20);
            }
        }
}
