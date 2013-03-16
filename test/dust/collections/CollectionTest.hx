package dust.collections;

import dust.components.BitfieldFactory;
import dust.components.Bitfield;
import dust.entities.api.CollectionListeners;
import dust.entities.impl.EmptyCollectionListeners;
import dust.entities.api.CollectionListeners;
import dust.entities.impl.SimpleCollectionListeners;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;
import dust.entities.api.Collection;
import dust.lists.SimpleList;
import dust.entities.impl.SimpleEntityList;
import massive.munit.Assert;

using Lambda;

class CollectionTest
{
    function emptyMethod(entity:Entity) {}

    var bitfieldFactory:BitfieldFactory;
    var collectionConnector:CollectionConnector;
    var entities:Entities;

    var collectionBitfield:Bitfield;
    var list:SimpleEntityList;
    var added:Entity;
    var removed:Entity;
    var collection:Collection;

    var entityBitfield:Bitfield;
    var entity:Entity;

    @Before public function before()
    {
        bitfieldFactory = new BitfieldFactory();
        collectionConnector = new CollectionConnector();
        entities = new Entities(collectionConnector, bitfieldFactory);

        collectionBitfield = bitfieldFactory.makeEmpty();
        list = new SimpleEntityList(new SimpleList<Entity>());
        collection = new Collection(collectionBitfield, list, onEntityAdded, onEntityRemoved);

        entityBitfield = bitfieldFactory.makeEmpty();
        entity = new Entity(entities, entityBitfield, collectionConnector);
    }

        function onEntityAdded(entity:Entity)
            added = entity

        function onEntityRemoved(entity:Entity)
            removed = entity

    @Test public function satisfyingEntityIsAdded()
    {
        collectionBitfield.assert(1);
        entityBitfield.assert(1);

        collection.add(entity);
        Assert.isTrue(collection.has(entity));
    }

    @Test public function nonSatisfyingEntityNotAdded()
    {
        collectionBitfield.assert(1);
        entityBitfield.assert(2);

        collection.add(entity);
        Assert.isFalse(collection.has(entity));
    }

    @Test public function nonSatisfyingEntityIsRemoved()
    {
        addThenRemoveEntity();
        Assert.isFalse(collection.has(entity));
    }

    @Test public function addedThenRemovedEntityIsNotIteratedOver()
    {
        addThenRemoveEntity();
        Assert.isFalse(isEntityIteratedOver());
    }

        function addThenRemoveEntity()
        {
            collectionBitfield.assert(1);
            entityBitfield.assert(1);
            collection.add(entity);

            entityBitfield.clear(1);
            collection.remove(entity);
        }

        function isEntityIteratedOver():Bool
        {
            var isIteratedOver = false;
            for (other in collection)
            {
                if (other == entity)
                    isIteratedOver = true;
            }
            return isIteratedOver;
        }
}