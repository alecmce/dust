package dust.collections;

import dust.collections.control.CollectionSubscriber;
import dust.bitfield.MockComponentA;
import dust.collections.data.CollectionList;
import dust.collections.control.CollectionMap;
import dust.entities.EntitiesConfig;
import dust.context.Context;
import dust.Injector;

import flash.display.Sprite;

class CollectionsConfigTest
{
    var injector:Injector;
    var context:Context;

    var map:CollectionMap;
    var list:CollectionList;

    @Before public function before()
    {
        context = new Context()
            .configure(CollectionsConfig)
            .start(new Sprite());

        injector = context.injector;
        map = injector.getInstance(CollectionMap);
        list = injector.getInstance(CollectionList);
    }

    @Test public function collectionsIsInjected()
    {
        Assert.isNotNull(map);
    }

    @Test public function collectionSubscriberIsInjected()
    {
        Assert.isTrue(injector.hasMapping(CollectionSubscriber));
    }

    @Test public function onceACollectionIsRetrievedItIsInList()
    {
        var collection = map.map([MockComponentA]).getCollection();
        Assert.listIncludes(list.iterator(), collection);
    }
}
