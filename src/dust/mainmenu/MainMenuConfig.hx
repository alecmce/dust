package dust.mainmenu;

import dust.mainmenu.control.DisableMenuSignal;
import dust.mainmenu.control.EnableMenuSignal;
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

    var menu:MainMenu;

    public function dependencies():Array<Class<Config>>
    {
        return [SignalMapConfig];
    }

    public function configure()
    {
        injector.mapValue(MainMenu, menu = new MainMenu());

        signalMap.map(EnableMenuSignal, menu.enable);
        signalMap.map(DisableMenuSignal, menu.disable);
    }
}
