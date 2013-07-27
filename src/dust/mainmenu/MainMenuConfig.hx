package dust.mainmenu;

import flash.display.DisplayObjectContainer;
import dust.app.data.App;
import dust.app.AppConfig;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.mainmenu.control.MainMenuButtonFactory;
import dust.graphics.data.Paint;
import dust.text.control.BitmapFonts;
import dust.mainmenu.data.MainMenuButtonConfig;
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
        return [AppConfig, SignalMapConfig, SmallWhiteHelveticaFontConfig];

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

            return if (app.isRetina())
                new MainMenuButtonConfig(app, font, paint, 320, 80, 40);
            else
                new MainMenuButtonConfig(app, font, paint, 160, 40, 20);
        }
}
