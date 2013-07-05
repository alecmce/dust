package dust.collections.api;

import dust.entities.PooledEntities;
import dust.entities.PooledEntity;
import dust.components.BitfieldFactory;
import dust.components.Bitfield;
import dust.collections.api.CollectionListeners;
import dust.collections.data.EmptyCollectionListeners;
import dust.collections.api.CollectionListeners;
import dust.collections.data.SimpleCollectionListeners;
import dust.entities.Entity;
import dust.entities.Entities;
import dust.collections.api.Collection;
import dust.lists.SimpleList;
import dust.entities.EntityList;

using Lambda;

class CollectionTest
{
    function emptyMethod(entity:Entity) {}

    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;

    var collectionBitfield:Bitfield;
    var list:EntityList;
    var added:Entity;
    var removed:Entity;
    var collection:Collection;

    var entityBitfield:Bitfield;
    var entity:Entity;

    @Before public function before()
    {
        bitfieldFactory = new BitfieldFactory();
        entities = new PooledEntities(bitfieldFactory);

        collectionBitfield = bitfieldFactory.makeEmpty();
        list = new EntityList(new SimpleList<Entity>());
        collection = new Collection(collectionBitfield, list, onEntityAdded, onEntityRemoved);

        entityBitfield = bitfieldFactory.makeEmpty();
        entity = new PooledEntity(1, entityBitfield);
    }

        function onEntityAdded(entity:Entity)
            added = entity;

        function onEntityRemoved(entity:Entity)
            removed = entity;

    @Test public function canDetectWhenEntityMeetsRequirements()
    {
        collectionBitfield.assert(1);
        entityBitfield.assert(1);
        Assert.isTrue(collection.meetsRequirements(entity));
    }

    @Test public function canDetectWhenEntityDoesNotMeetRequirements()
    {
        collectionBitfield.assert(1);
        entityBitfield.assert(2);
        collection.add(entity);
        Assert.isFalse(collection.meetsRequirements(entity));
    }

    @Test public function reportsWhetherRemovedEntityIsMember()
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
            collection.add(entity);
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