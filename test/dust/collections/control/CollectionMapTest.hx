package dust.collections.control;

import flash.display.Sprite;
import dust.context.Context;
import dust.collections.control.CollectionMap;
import dust.collections.control.CollectionMapping;
import dust.bitfield.MockComponentA;
import dust.bitfield.MockComponentB;
import dust.entities.Entity;
import dust.entities.Entities;

import dust.Injector;

using Lambda;

class CollectionMapTest
{
    var entities:Entities;
    var collectionMap:CollectionMap;

    @Before public function before()
    {
        var context = new Context()
            .configure(CollectionsConfig)
            .start(new Sprite());

        entities = context.injector.getInstance(Entities);
        collectionMap = context.injector.getInstance(CollectionMap);
    }

    @Test public function mapReturnsConfig()
    {
        Assert.isType(collectionMap.map([MockComponentA]), CollectionMapping);
    }

    @Test public function sameDefinitionsReturnSameMapping()
    {
        var first = collectionMap.map([MockComponentA]);
        var second = collectionMap.map([MockComponentA]);
        Assert.areSame(first, second);
    }

    @Test public function differentDefinitionsReturnDifferentMappings()
    {
        var first = collectionMap.map([MockComponentA]);
        var second = collectionMap.map([MockComponentB]);
        Assert.areNotSame(first, second);
    }

    @Test public function satisfyingEntitiesAreAddedAtFirstMomentOfConstruction()
    {
        var entity = entities.require();
        entity.add(new MockComponentA());

        var config = collectionMap.map([MockComponentA]);
        var collection = config.getCollection();
        Assert.isTrue(collection.has(entity));
    }

    @Test public function unsatisfyingEntitiesAreNotMembersOfCollection()
    {
        var config = collectionMap.map([MockComponentA]);

        var entity = entities.require();
        entity.add(new MockComponentB());

        Assert.isFalse(config.getCollection().has(entity));
    }
}