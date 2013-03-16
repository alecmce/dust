package dust.collections;

import dust.components.MockComponentB;
import dust.components.MockComponentA;
import dust.components.Component;
import dust.components.BitfieldFactory;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionMap;
import dust.entities.impl.CollectionConnector;
import dust.entities.impl.CollectionMapping;

import minject.Injector;
import massive.munit.Assert;

using Lambda;

class CollectionMapTest
{
    var injector:Injector;
    var collectionConnector:CollectionConnector;
    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;
    var collectionMap:CollectionMap;

    @Before public function before()
    {
        injector = new Injector();
        collectionConnector = new CollectionConnector();
        bitfieldFactory = new BitfieldFactory();
        entities = new Entities(collectionConnector, bitfieldFactory);
        collectionMap = new CollectionMap(injector, collectionConnector, bitfieldFactory, entities);
    }

    @Test public function mapReturnsConfig()
    {
        var components:Array<Class<Component>> = [MockComponentA];
        Assert.isType(collectionMap.map(components), CollectionMapping);
    }

    @Test public function sameDefinitionsReturnSameMapping()
    {
        var first:Array<Class<Component>> = [MockComponentA];
        var second:Array<Class<Component>> = [MockComponentA];
        Assert.areSame(collectionMap.map(first), collectionMap.map(second));
    }

    @Test public function differentDefinitionsReturnDifferentMappings()
    {
        var first:Array<Class<Component>> = [MockComponentA];
        var second:Array<Class<Component>> = [MockComponentB];
        Assert.areNotSame(collectionMap.map(first), collectionMap.map(second));
    }

    @Test public function retrievedCollectionIncludesEntities()
    {
        var components:Array<Class<Component>> = [MockComponentA];
        var config = collectionMap.map(components);

        var entity = entities.require();
        entity.add(new MockComponentA());

        var collection = config.getCollection();

        Assert.isTrue(collection.has(entity));
    }

    @Test public function unsatisfyingEntitiesAreNotMembersOfCollection()
    {
        var components:Array<Class<Component>> = [MockComponentA];
        var config = collectionMap.map(components);

        var entity = entities.require();
        entity.add(new MockComponentB());

        Assert.isFalse(config.getCollection().has(entity));
    }

//    @Test //    public function collectionsReportToListenersWhenEntityIsAdded()
//    {
//        var components:Array<Class<Component>> = [MockComponentA];
//        collectionMap.map(components)
//            .addListener(MockCollectionListeners);
//        collectionMap.instantiateAllCollections();
//
//        var entity = entities.require();
//        entity.add(new MockComponentA());
//        Assert.areSame(listenedToEntity, entity);
//    }
//
//    @Test //    public function collectionsReportToListenersWhenEntityIsRemoved()
//    {
//        var components:Array<Class<Component>> = [MockComponentA];
//        collectionMap.map(components)
//            .addListener(MockCollectionListeners);
//        collectionMap.instantiateAllCollections();
//
//        var entity = entities.require();
//        entity.add(new MockComponentA());
//        entity.remove(MockComponentA);
//        Assert.areSame(listenedToEntity, entity);
//    }
}
