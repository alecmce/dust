package dust.systems.systems;

import dust.systems.impl.Systems;
import nme.display.Sprite;
import dust.context.Context;
import dust.Injector;

class UpdateCollectionsSystemTest
{
    var systems:Systems;
    var system:UpdateCollectionsSystem;

    @Before public function before()
    {
        var context = new Context()
            .configure(SystemsConfig)
            .start(new Sprite());

        systems = context.injector.getInstance(Systems);
        system = context.injector.getInstance(UpdateCollectionsSystem);
    }
}
