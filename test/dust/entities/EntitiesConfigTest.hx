package dust.entities;

import minject.Injector;
import dust.entities.EntitiesConfig;
import dust.context.Context;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entities;

import nme.display.Sprite;

class EntitiesConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        injector = new Injector();
        context = new Context(injector)
            .configure(EntitiesConfig)
            .start(new Sprite());
    }

    @Test public function entitiesIsInjected()
    {
        var entities = injector.getInstance(Entities);
        Assert.isNotNull(entities);
    }
}
