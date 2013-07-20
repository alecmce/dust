package dust.collections.control;

import dust.bitfield.MockComponentB;
import dust.entities.Entity;
import dust.collections.api.Collection;
import dust.bitfield.MockComponentA;
import dust.entities.Entities;
import flash.display.Sprite;
import dust.context.Context;
import dust.Injector;
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
        var context = new Context()
            .configure(CollectionsConfig)
            .start(new Sprite());

        entities = context.injector.getInstance(Entities);
        collections = context.injector.getInstance(CollectionMap);
        subscriber = context.injector.getInstance(CollectionSubscriber);

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

    @Test public function canSubscribeUnsubscribeAndResubscribeToACollection()
    {
        addComponentToEntityAndUpdate();
        removeComponentFromEntityAndUpdate();
        addComponentToEntityAndUpdate();
        Assert.listIncludes(collection.iterator(), entity);
    }

    @Test public function partialSatisfactionDoesNotMeanSubscription()
    {
        collection = collections.map([MockComponentA, MockComponentB]).getCollection();
        entity.add(new MockComponentB());
        Assert.listExcludes(collection.iterator(), entity);
    }

    @Test public function resubscribeWorksWithPartialCollectionSatisfaction()
    {
        collection = collections.map([MockComponentA, MockComponentB]).getCollection();
        entity.add(new MockComponentB());
        addComponentToEntityAndUpdate();
        removeComponentFromEntityAndUpdate();
        addComponentToEntityAndUpdate();
        Assert.listIncludes(collection.iterator(), entity);
    }
}
