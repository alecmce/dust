package dust.systems.impl;

import dust.entities.impl.PooledEntities;
import dust.collections.data.CollectionList;
import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemMapping;
import dust.components.BitfieldFactory;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entities;

import dust.Injector;

class SystemMapTest
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var systemMap:SystemMap;

    @Before public function before()
    {
        injector = new Injector();
        collectionMap = makeCollectionMap();
        systemMap = new SystemMap(injector, collectionMap);
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
}
