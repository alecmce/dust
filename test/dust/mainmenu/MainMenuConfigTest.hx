package dust.mainmenu;

import nme.display.BitmapData;
import nme.Assets;
import dust.context.Context;
import dust.Injector;
import nme.display.Sprite;

class MainMenuConfigTest
{
    var injector:Injector;
    var context:Context;

    function configure()
    {
        context = new Context(injector = new Injector())
            .configure(MainMenuConfig)
            .start(new Sprite());
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
