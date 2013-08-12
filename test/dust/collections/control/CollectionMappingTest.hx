package dust.collections.control;

import dust.bitfield.MockComponentA;
import dust.commands.MockCommand;
import dust.entities.Entity;
import dust.entities.Entities;
import dust.collections.api.Collection;
import dust.collections.api.CollectionListeners;
import flash.display.Sprite;
import dust.context.Context;

class CollectionMappingTest
{
    var injector:Injector;
    var entities:Entities;
    var collections:CollectionMap;

    @Before public function before()
    {
        MockCollectionListeners.count = 0;

        var context = new Context()
            .configure(CollectionsConfig)
            .start(new Sprite());

        injector = context.injector;
        entities = injector.getInstance(Entities);
        collections = injector.getInstance(CollectionMap);
    }

    @Test public function test()
    {
        var mapping:CollectionMapping = collections.map([MockComponentA]);
        var collection:Collection = mapping.getCollection();
        mapping.toListeners(MockCollectionListeners);
        collection.add(entities.require());

        Assert.areEqual(1, MockCollectionListeners.count);
    }
}

class MockCollectionListeners implements CollectionListeners
{
    public static var count:Int = 0;

    public function onEntityAdded(entity:Entity)
    {
        ++count;
    }

    public function onEntityRemoved(entity:Entity)
    {
        --count;
    }
}