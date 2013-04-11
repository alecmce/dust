package dust.collections.control;

import dust.entities.api.Entity;
import dust.collections.api.CollectionListeners;
import dust.components.MockComponentA;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import nme.display.Sprite;
import dust.context.Context;
import dust.entities.api.Entities;

class CollectionUpdateTest
{
    var entities:Entities;
    var collectionMap:CollectionMap;
    var systems:Systems;

    @Before public function before()
    {
        var context = new Context()
            .configure(CollectionsConfig)
            .configure(SystemsConfig)
            .start(new Sprite());

        entities = context.injector.getInstance(Entities);
        collectionMap = context.injector.getInstance(CollectionMap);
        systems = context.injector.getInstance(Systems);
    }

    @Test public function collectionListenersOnAddedCalledWhenEntitySatisfiesCollection()
    {
        collectionMap.map([MockComponentA]).toListeners(MockListeners);
        collectionMap.instantiateAll();

        var entity = entities.require();
        entity.add(new MockComponentA());
        systems.update();

        Assert.isTrue(MockListeners.isAdded);
    }

    @Test public function collectionListenersOnRemoveCalledWhenEntityNoLongerSatisfiesCollection()
    {
        collectionMap.map([MockComponentA]).toListeners(MockListeners);
        collectionMap.instantiateAll();

        var entity = entities.require();
        entity.add(new MockComponentA());
        systems.update();

        entity.remove(MockComponentA);
        systems.update();
        Assert.isTrue(MockListeners.isRemoved);
    }

    @Test public function removeInSelfRemovingListenersWorks()
    {
        collectionMap.map([MockComponentA]).toListeners(MockSelfRemovingListeners);
        collectionMap.instantiateAll();

        var entity = entities.require();
        entity.add(new MockComponentA());
        systems.update();

        Assert.isFalse(entity.has(MockComponentA));
    }

    @Test public function selfRemovingListenersGetRemovedCall()
    {
        collectionMap.map([MockComponentA]).toListeners(MockSelfRemovingListeners);
        collectionMap.instantiateAll();

        var entity = entities.require();
        entity.add(new MockComponentA());
        systems.update();
        systems.update();

        Assert.isTrue(MockListeners.isRemoved);
    }
}

class MockListeners implements CollectionListeners
{
    public static var isAdded:Bool;
    public static var isRemoved:Bool;

    public function new()
    {
        isAdded = false;
        isRemoved = false;
    }

    public function onEntityAdded(entity:Entity)
        isAdded = true

    public function onEntityRemoved(entity:Entity)
        isRemoved = true
}

class MockSelfRemovingListeners implements CollectionListeners
{
    public static var isAdded:Int;
    public static var isRemoved:Int;

    public function new()
    {
        isAdded = false;
        isRemoved = false;
    }

    public function onEntityAdded(entity:Entity)
    {
        isAdded = true;
        entity.remove(MockComponentA);
    }

    public function onEntityRemoved(entity:Entity)
        isRemoved = true
}

