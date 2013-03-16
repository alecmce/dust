package dust.systems;

import dust.systems.impl.SystemMap;
import dust.position.data.Position;
import dust.systems.SystemMappingTest.MockNamedCollectionSystem;
import dust.systems.SystemMappingTest.MockNamedCollectionSystem;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemMapping;
import dust.systems.impl.TimedSystem;
import dust.systems.impl.SystemsLoop;
import dust.systems.System;
import dust.components.BitfieldFactory;
import dust.entities.impl.CollectionConnector;
import dust.entities.impl.CollectionMap;
import dust.entities.api.Collection;
import dust.components.Component;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.components.MockComponentA;

import massive.munit.Assert;
import minject.Injector;

import massive.munit.Assert;

class SystemMappingTest
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var list:SystemsList;
    var loop:TestSystemsLoop;
    var mapping:SystemMapping;

    function assertCollectionHasComponentAsDefinien(collection:Collection, component:Class<Component>)
    {
        var componentID = (cast component).ID;
        Assert.isTrue(collection.bitfield.get(componentID));
    }

    @Before public function before()
    {
        injector = new Injector();
        collectionMap = makeCollectionMap();
        list = new SystemsList();
        loop = new TestSystemsLoop(list);
    }

        function makeCollectionMap():CollectionMap
        {
            var bitfieldFactory = new BitfieldFactory();
            var collectionConnector = new CollectionConnector();
            var entities = new Entities(collectionConnector, bitfieldFactory);
            return new CollectionMap(injector, collectionConnector, bitfieldFactory, entities);
        }

        function makeSystemMapping(system:Class<System>):SystemMapping
            return new SystemMapping(injector, collectionMap, system)

    @Test public function canApplySystemMappingToSystemList()
    {
        mapping = makeSystemMapping(MockMappedSystem);
        mapping.apply(loop);
        Assert.isType(loop.addedSystem, MockMappedSystem);
    }

    @Test public function timedUpdateMeansSystemIsWrappedInTimedSystem()
    {
        mapping = makeSystemMapping(MockMappedSystem);
        mapping.withTimedUpdate(1000);
        mapping.apply(loop);
        Assert.isType(loop.addedSystem, TimedSystem);
    }

    @Test public function withCollectionDefinesCollectionInjectedIntoSystem()
    {
        mapping = makeSystemMapping(MockCollectionSystem);
        mapping.toCollection([MockComponentA]);
        mapping.apply(loop);

        var system:MockCollectionSystem = cast loop.addedSystem;
        Assert.isType(system.collection, Collection);
    }

    @Test public function withSortedCollectionDefinesSortedCollectionInjectedIntoSystem()
    {
        mapping = makeSystemMapping(MockCollectionSystem);
        mapping.toCollection([SortableComponent]);
        mapping.withSorter(sortMethod);
        mapping.apply(loop);

        var system:MockCollectionSystem = cast loop.addedSystem;
        Assert.isType(system.collection, Collection);
    }

        function sortMethod(a:Entity, b:Entity):Int
            return a.get(SortableComponent).priority - b.get(SortableComponent).priority

    @Test public function canNameCollectionMapping()
    {
        mapping = makeSystemMapping(MockNamedCollectionSystem);
        mapping.toCollection([SortableComponent], "test");
        mapping.apply(loop);

        var system:MockNamedCollectionSystem = cast loop.addedSystem;
        assertCollectionHasComponentAsDefinien(system.collection, SortableComponent);
    }

    @Test public function firstCollectionCanBeNamedInTwoCollectionSystem()
    {
        mapping = makeSystemMapping(MockTwoNamedCollectionsSystem);
        mapping.toCollection([SortableComponent], "first");
        mapping.toCollection([Position], "second");
        mapping.apply(loop);

        assertCollectionHasComponentAsDefinien((cast loop.addedSystem).first, SortableComponent);
    }

    @Test public function secondCollectionCanBeNamedInTwoCollectionSystem()
    {
        mapping = makeSystemMapping(MockTwoNamedCollectionsSystem);
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

class SortableComponent extends Component
{
    public var priority:Int;
}