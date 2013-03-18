package dust.collections.control;

import nme.display.Sprite;
import dust.context.Context;
import dust.collections.control.CollectionMap;
import dust.collections.control.CollectionMapping;
import dust.collections.data.CollectionList;
import dust.components.BitfieldFactory;
import dust.components.Component;
import dust.components.MockComponentA;
import dust.components.MockComponentB;
import dust.entities.api.Entity;
import dust.entities.api.Entities;

import minject.Injector;

using Lambda;

class CollectionMapTest
{
    var entities:Entities;
    var collectionMap:CollectionMap;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(CollectionsConfig)
            .start(new Sprite());

        entities = injector.getInstance(Entities);
        collectionMap = injector.getInstance(CollectionMap);
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
        var components:Array<Class<Component>> = [MockComponentA];
        var config = collectionMap.map(components);

        var entity = entities.require();
        entity.add(new MockComponentB());

        Assert.isFalse(config.getCollection().has(entity));
    }
}
