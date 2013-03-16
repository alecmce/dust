package dust.systems;

import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemMapping;
import dust.components.BitfieldFactory;
import dust.entities.impl.CollectionMap;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;

import massive.munit.Assert;
import minject.Injector;

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
            var bitfieldFactory = new BitfieldFactory();
            var collectionConnector = new CollectionConnector();
            var entities = new Entities(collectionConnector, bitfieldFactory);
            return new CollectionMap(injector, collectionConnector, bitfieldFactory, entities);
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
