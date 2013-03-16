package dust.collections;

import dust.components.BitfieldFactory;
import dust.components.Bitfield;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;
import dust.entities.api.Collection;
import dust.lists.SimpleList;
import dust.entities.impl.EntityList;
import dust.entities.impl.SimpleEntityList;
import massive.munit.Assert;

class CollectionConnectorTest
{
    var collectionConnector:CollectionConnector;
    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;
    var entity:Entity;
    var entityBitfield:Bitfield;
    var bitfield:Bitfield;
    var collection:MockCollection;

    @Before public function before()
    {
        collectionConnector = new CollectionConnector();
        bitfieldFactory = new BitfieldFactory();
        entities = new Entities(collectionConnector, bitfieldFactory);
        entityBitfield = new Bitfield(1);
        entity = new Entity(entities, entityBitfield, collectionConnector);
        bitfield = new Bitfield(1);
        collection = new MockCollection(bitfield);
    }

    @Test public function updateOnAddedIsCalledForCollectionsThatBitfieldMatch()
    {
        bitfield.assert(1);
        collectionConnector.addCollection(collection);

        entityBitfield.assert(1);
        collectionConnector.updateCollectionsOnComponentAdded(1, entity);
        Assert.areSame(collection.added, entity);
    }

    @Test public function updateOnAddedIsNotCalledForCollectionsWithoutBitfieldMatch()
    {
        bitfield.assert(1);
        collectionConnector.addCollection(collection);

        entityBitfield.assert(2);
        collectionConnector.updateCollectionsOnComponentAdded(2, entity);
        Assert.isNull(collection.added);
    }
}

class MockCollection extends Collection
{
    public var added:Entity;
    public var deleted:Entity;

    public function new(bitfield:Bitfield)
    {
        super(bitfield, makeEntityList(), addEntityToCollection, removeEntityFromCollection);
    }

        function makeEntityList():EntityList
        {
            var list = new SimpleList<Entity>();
            return new SimpleEntityList(list);
        }

    public function addEntityToCollection(entity:Entity)
    {
        added = entity;
    }

    public function removeEntityFromCollection(entity:Entity)
    {
        deleted = entity;
    }
}