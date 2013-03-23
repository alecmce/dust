package dust.collections.control;

import dust.entities.api.Entity;
import dust.collections.api.Collection;
import dust.components.MockComponentA;
import dust.entities.api.Entities;
import nme.display.Sprite;
import dust.context.Context;
import minject.Injector;
import dust.collections.data.CollectionList;

class CollectionSubscriberTest
{
    var entities:Entities;
    var collections:CollectionMap;
    var subscriber:CollectionSubscriber;

    var entity:Entity;
    var collection:Collection;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(CollectionsConfig)
            .start(new Sprite());

        entities = injector.getInstance(Entities);
        collections = injector.getInstance(CollectionMap);
        subscriber = injector.getInstance(CollectionSubscriber);

        entity = entities.require();
        collection = collections.map([MockComponentA]).getCollection();
    }

        function addComponentToEntityAndUpdate()
        {
            entity.add(new MockComponentA());
            subscriber.updateEntity(entity);
        }

        function removeComponentFromEntityAndUpdate()
        {
            entity.remove(MockComponentA);
            subscriber.updateEntity(entity);
        }

    @Test public function afterUpdateEntityIsNotMemberOfUnsatisfiedCollection()
    {
        subscriber.updateEntity(entity);
        Assert.listExcludes(collection.iterator(), entity);
    }

    @Test public function afterUpdateEntityWillBeMemberOfSatisfiedCollection()
    {
        addComponentToEntityAndUpdate();
        Assert.listIncludes(collection.iterator(), entity);
    }

    @Test public function afterUpdateEntityNoLongerSatisfyingCollectionWillBeRemoved()
    {
        addComponentToEntityAndUpdate();
        removeComponentFromEntityAndUpdate();
        Assert.listExcludes(collection.iterator(), entity);
    }

    @Test public function afterEntityRemoveAllCollectionsAreUpdated()
    {
        addComponentToEntityAndUpdate();
        entity.removeAll();
        subscriber.updateEntity(entity);
        Assert.listExcludes(collection.iterator(), entity);
    }
}
