package dust.systems.impl;

import flash.display.Sprite;
import dust.context.Context;
import dust.entities.PooledEntities;
import dust.collections.data.CollectionList;
import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemMapping;
import dust.components.BitfieldFactory;
import dust.collections.control.CollectionMap;
import dust.entities.Entities;

import dust.Injector;

class SystemMapTest
{
    public static var INDEX = 0;

    var injector:Injector;
    var collectionMap:CollectionMap;
    var systemMap:SystemMap;
    var systems:Systems;

    @Before public function before()
    {
        INDEX = 0;

        var context = new Context()
            .configure(SystemsConfig)
            .start(new Sprite());

        injector = context.injector;
        collectionMap = injector.getInstance(CollectionMap);
        systemMap = injector.getInstance(SystemMap);
        systems = injector.getInstance(Systems);
    }

        function makeCollectionMap():CollectionMap
        {
            var map = new CollectionMap();
            map.injector = injector;
            map.bitfieldFactory = new BitfieldFactory();
            map.entities = new PooledEntities(map.bitfieldFactory);
            map.collectionList = new CollectionList();
            return map;
        }

    @Test public function mappingATypeReturnsASystemMapping()
    {
        var mapping = systemMap.map(MockSystem);
        Assert.isType(mapping, SystemMapping);
    }

    @Test public function mappingSameSystemTwiceReturnsSameMapping()
    {
        var first = systemMap.map(MockSystem);
        var second = systemMap.map(MockSystem);
        Assert.areSame(first, second);
    }

    @Test public function unmappingRemovesMappingSoMapReturnsNewInstance()
    {
        var first = systemMap.map(MockSystem);
        systemMap.unmap(MockSystem);
        var second = systemMap.map(MockSystem);
        Assert.areNotSame(first, second);
    }

    @Test public function systemsRunInOrderOfMappingByDefault()
    {
        systemMap.map(MockSystemA);
        systemMap.map(MockSystemB);
        systems.start();
        systems.update();

        Assert.areEqual(MockSystemA.index, 1);
        Assert.areEqual(MockSystemB.index, 2);
    }

    @Test public function systemsRunInOrderOfPriorityIfDefined()
    {
        var first = systemMap.map(MockSystemA, 1);
        var second = systemMap.map(MockSystemB, 2);

        systems.start();
        systems.update();

        Assert.areEqual(MockSystemA.index, 2);
        Assert.areEqual(MockSystemB.index, 1);
    }
}

class MockSystemA implements System
{
    public static var index:Int;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        index = ++SystemMapTest.INDEX;
    }
}

class MockSystemB implements System
{
    public static var index:Int;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        index = ++SystemMapTest.INDEX;
    }
}