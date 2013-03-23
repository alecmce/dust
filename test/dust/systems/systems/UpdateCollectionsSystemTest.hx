package dust.systems.systems;

import dust.systems.impl.Systems;
import nme.display.Sprite;
import dust.context.Context;
import minject.Injector;

class UpdateCollectionsSystemTest
{
    var systems:Systems;
    var system:UpdateCollectionsSystem;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(SystemsConfig)
            .start(new Sprite());

        systems = injector.getInstance(Systems);
        system = injector.getInstance(UpdateCollectionsSystem);
    }
}
