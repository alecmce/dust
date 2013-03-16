package dust.collections;

import dust.components.BitfieldFactory;
import dust.components.Bitfield;
import minject.Injector;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;
import dust.entities.impl.CollectionMapping;
import dust.entities.api.Collection;
import dust.entities.impl.EntityList;
import dust.entities.impl.SimpleEntityList;
import dust.entities.impl.SortedEntityList;
import dust.lists.LinkedList;
import dust.lists.SimpleList;
import dust.lists.SortedList;

import massive.munit.Assert;

class CollectionConfigTest
{
    var mapping:CollectionMapping;

    @Before public function before()
    {
        var injector = new Injector();
        var bitfield = new Bitfield(1);
        var collectionConnector = new CollectionConnector();
        var bitfieldFactory = new BitfieldFactory();
        var entities = new Entities(collectionConnector, bitfieldFactory);
        mapping = new CollectionMapping(injector, bitfield, entities, collectionConnector);
    }

    @Test public function vanillaProviderMakesCollection()
    {
        var collection = mapping.getCollection();
        Assert.isType(collection, Collection);
    }

    @Test public function alwaysProvidesSameCollection()
    {
        var first = mapping.getCollection();
        var second = mapping.getCollection();
        Assert.areSame(first, second);
    }


}