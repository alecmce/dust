package dust.mainmenu;

import dust.app.data.AppTarget;
import nme.display.DisplayObjectContainer;
import dust.app.data.App;
import dust.app.AppConfig;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.mainmenu.control.MainMenuButtonFactory;
import dust.graphics.data.Paint;
import dust.text.Fixed24WhiteMichromaFontConfig;
import dust.text.control.BitmapFontFactory;
import dust.text.control.BitmapFonts;
import dust.mainmenu.data.MainMenuButtonConfig;
import dust.text.BitmapTextConfig;
import dust.signals.SignalMap;
import dust.mainmenu.MainMenu;
import dust.Injector;
import dust.signals.SignalMapConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class MainMenuConfig implements DependentConfig
{
    @inject public var app:App;
    @inject public var injector:Injector;
    @inject public var signalMap:SignalMap;
    @inject public var fonts:BitmapFonts;
    @inject public var root:DisplayObjectContainer;

    public function dependencies():Array<Class<Config>>
        return [AppConfig, SignalMapConfig, SmallWhiteHelveticaFontConfig]

    public function configure()
    {
        injector.mapValue(MainMenuButtonConfig, makeConfig());
        injector.mapSingleton(MainMenuButtonFactory);
        injector.mapSingleton(MainMenu);

        root.addChild(injector.getInstance(MainMenu));
    }

        function makeConfig():MainMenuButtonConfig
        {
            var font = fonts.get(SmallWhiteHelveticaFontConfig.FONT);
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
