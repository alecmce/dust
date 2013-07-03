package dust.entities;

import dust.Injector;
import dust.entities.EntitiesConfig;
import dust.context.Context;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entities;

import flash.display.Sprite;

class EntitiesConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        context = new Context()
            .configure(EntitiesConfig)
            .start(new Sprite());
        injector = context.injector;
    }

    @Test public function entitiesIsInjected()
    {
        var entities = injector.getInstance(Entities);
        Assert.isNotNull(entities);
    }
}
