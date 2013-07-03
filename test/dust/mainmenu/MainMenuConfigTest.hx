package dust.mainmenu;

import flash.display.BitmapData;
import openfl.Assets;
import dust.context.Context;
import dust.Injector;
import flash.display.Sprite;

class MainMenuConfigTest
{
    var injector:Injector;
    var context:Context;

    function configure()
    {
        context = new Context()
            .configure(MainMenuConfig)
            .start(new Sprite());
        injector = context.injector;
    }

    @Test public function configuresWithoutErrors()
    {
        configure();
    }

    @Test public function canInstantiateMainMenu()
    {
        configure();
        Assert.isNotNull(injector.getInstance(MainMenu));
    }
}
