package dust.systems.impl;

import dust.entities.PooledEntities;
import dust.collections.api.Collection;
import dust.collections.control.CollectionSubscriber;
import dust.collections.control.CollectionMap;
import dust.collections.data.CollectionList;
import dust.components.BitfieldFactory;
import dust.components.MockComponentA;
import dust.context.Context;
import dust.geom.data.Position;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemMapping;
import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.TimedSystem;
import dust.systems.System;
import dust.entities.Entity;
import dust.entities.Entities;

import dust.Injector;
import flash.display.Sprite;

class SystemMappingTest
{
    var injector:Injector;
    var context:Context;

    var systemMap:SystemMap;
    var collectionMap:CollectionMap;
    var collectionSorts:CollectionSorts;

    var list:SystemsList;
    var loop:TestSystemsLoop;
    var mapping:SystemMapping;

    function assertCollectionHasComponentAsDefinien(collection:Collection, component:Class<Dynamic>)
    {
        var componentID = (cast component).ID;
        Assert.isTrue(collection.bitfield.get(componentID));
    }

    @Before public function before()
    {
        context = new Context()
            .configure(SystemsConfig)
            .start(new Sprite());

        systemMap = context.injector.getInstance(SystemMap);
        collectionMap = context.injector.getInstance(CollectionMap);
        collectionSorts = context.injector.getInstance(CollectionSorts);

        list = context.injector.getInstance(SystemsList);
        loop = new TestSystemsLoop(list);
    }

    @Test public function canApplySystemMappingToSystemList()
    {
        mapping = systemMap.map(MockMappedSystem);
        mapping.apply(loop);
        Assert.isType(loop.addedSystem, MockMappedSystem);
    }

    @Test public function timedUpdateMeansSystemIsWrappedInTimedSystem()
    {
        mapping = systemMap.map(MockMappedSystem);
        mapping.withTimedUpdate(1000);
        mapping.apply(loop);
        Assert.isType(loop.addedSystem, TimedSystem);
    }

    @Test public function withCollectionDefinesCollectionInjectedIntoSystem()
    {
        mapping = systemMap.map(MockCollectionSystem);
        mapping.toCollection([MockComponentA]);
        mapping.apply(loop);

        var system:MockCollectionSystem = cast loop.addedSystem;
        Assert.isType(system.collection, Collection);
    }

    @Test public function canNameCollectionMapping()
    {
        mapping = systemMap.map(MockNamedCollectionSystem);
        mapping.toCollection([SortableComponent], "test");
        mapping.apply(loop);

        var system:MockNamedCollectionSystem = cast loop.addedSystem;
        assertCollectionHasComponentAsDefinien(system.collection, SortableComponent);
    }

    @Test public function firstCollectionCanBeNamedInTwoCollectionSystem()
    {
        mapping = systemMap.map(MockTwoNamedCollectionsSystem);
        mapping.toCollection([SortableComponent], "first");
        mapping.toCollection([Position], "second");
        mapping.apply(loop);

        assertCollectionHasComponentAsDefinien((cast loop.addedSystem).first, SortableComponent);
    }

    @Test public function secondCollectionCanBeNamedInTwoCollectionSystem()
    {
        mapping = systemMap.map(MockTwoNamedCollectionsSystem);
        mapping.toCollection([SortableComponent], "first");
        mapping.toCollection([Position], "second");
        mapping.apply(loop);

        assertCollectionHasComponentAsDefinien((cast loop.addedSystem).second, Position);
    }
}

class MockMappedSystem implements System
{
    public function new() {}

    public function start() {}
    public function stop() {}
    public function iterate(deltaTime:Float) {}
}

class MockCollectionSystem extends MockMappedSystem
{
    @inject public var collection:Collection;
}

class MockNamedCollectionSystem extends MockMappedSystem
{
    @inject("test") public var collection:Collection;
}

class MockTwoNamedCollectionsSystem extends MockMappedSystem
{
    @inject("first") public var first:Collection;
    @inject("second") public var second:Collection;
}

class TestSystemsLoop extends SystemsLoop
{
    public var addedSystem:System;

    override public function add(system:System)
    {
        super.add(system);
        addedSystem = system;
    }
}

class SortableComponent
{
    public var priority:Int;
}