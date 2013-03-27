package dust.collections.control;

import dust.collections.data.CollectionList;
import dust.collections.api.Collection;
import dust.Injector;
import dust.components.Component;
import dust.components.BitfieldFactory;
import dust.entities.impl.SimpleEntityList;
import dust.entities.impl.SortedEntityList;
import dust.entities.api.EntityList;
import dust.components.Bitfield;
import dust.entities.api.Entities;
import dust.lists.LinkedList;
import dust.lists.SimpleList;

class CollectionMap
{
    @inject public var injector:Injector;
    @inject public var bitfieldFactory:BitfieldFactory;
    @inject public var entities:Entities;
    @inject public var collectionList:CollectionList;
    @inject public var subscriber:CollectionSubscriber;

    var configMap:Hash<CollectionMapping>;

    public function new()
        configMap = new Hash<CollectionMapping>()

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
            var config = new CollectionMapping(injector, bitfield, collectionList, subscriber);
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