package dust.entities.impl;

import dust.entities.api.Collection;
import minject.Injector;
import dust.components.Component;
import dust.entities.impl.CollectionMapping;
import dust.components.BitfieldFactory;
import dust.entities.impl.SimpleEntityList;
import dust.entities.impl.SortedEntityList;
import dust.entities.impl.EntityList;
import dust.entities.impl.CollectionConnector;
import dust.components.Bitfield;
import dust.entities.api.Entities;
import dust.lists.LinkedList;
import dust.lists.SimpleList;

class CollectionMap
{
    var injector:Injector;
    var collectionConnector:CollectionConnector;
    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;

    var configMap:Hash<CollectionMapping>;

    @inject
    public function new(injector:Injector, collectionConnector:CollectionConnector, bitfieldFactory:BitfieldFactory, entities:Entities)
    {
        this.injector = injector;
        this.collectionConnector = collectionConnector;
        this.bitfieldFactory = bitfieldFactory;
        this.entities = entities;

        configMap = new Hash<CollectionMapping>();
    }

    public function map(components:Array<Class<Component>>):CollectionMapping
    {
        var bitfield = bitfieldFactory.make(components);
        var key = bitfield.toString();
        return getOrMakeMapping(key, bitfield);
    }

        function getOrMakeMapping(key:String, bitfield:Bitfield):CollectionMapping
        {
            return if (configMap.exists(key))
                configMap.get(key);
            else
                makeAndRecordMapping(key, bitfield);
        }

        function makeAndRecordMapping(key:String, bitfield:Bitfield):CollectionMapping
        {
            var config = new CollectionMapping(injector, bitfield, entities, collectionConnector);
            configMap.set(key, config);
            return config;
        }

    public function getCollection(components:Array<Class<Component>>):Collection
    {
        var bitfield = bitfieldFactory.make(components);
        var key = bitfield.toString();
        return getOrMakeMapping(key, bitfield).getCollection();
    }

    public function instantiateAll()
    {
        for (config in configMap)
            config.getCollection();
    }
}