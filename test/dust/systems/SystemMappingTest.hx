package dust.systems;

import dust.collections.api.Collection;
import dust.collections.control.CollectionSubscriber;
import dust.collections.control.CollectionMap;
import dust.collections.data.CollectionList;
import dust.components.BitfieldFactory;
import dust.components.Component;
import dust.components.MockComponentA;
import dust.context.Context;
import dust.geom.Position;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemMapping;
import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.TimedSystem;
import dust.systems.System;
import dust.systems.SystemMappingTest.MockNamedCollectionSystem;
import dust.entities.api.Entity;
import dust.entities.api.Entities;

import minject.Injector;
import nme.display.Sprite;

class SystemMappingTest
{
    var injector:Injector;
    var context:Context;

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
        var injector = new Injector();
        context = new Context(injector)
            .configure(SystemsConfig)
            .start(new Sprite());

        collectionMap = injector.getInstance(CollectionMap);
        list = injector.getInstance(SystemsList);
        loop = new TestSystemsLoop(list);
    }

        function makeCollectionMap():CollectionMap
        {
            var map = new CollectionMap();
            map.injector = injector;
            map.bitfieldFactory = new BitfieldFactory();
            map.entities = new Entities(map.bitfieldFactory);
            map.collectionList = new CollectionList();
            map.subscriber = new CollectionSubscriber();
            return map;
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