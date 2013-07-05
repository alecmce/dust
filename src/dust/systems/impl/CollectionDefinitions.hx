package dust.systems.impl;

import dust.components.Bitfield;
import dust.collections.control.CollectionMapping;
import dust.entities.Entity;
import dust.collections.api.Collection;
import dust.collections.control.CollectionMap;
import dust.Injector;

class CollectionDefinitions
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var sortedCollections:CollectionSorts;

    var list:Array<CollectionDefinition>;

    public function new(injector:Injector, collectionMap:CollectionMap, sortedCollections:CollectionSorts)
    {
        this.injector = injector;
        this.collectionMap = collectionMap;
        this.sortedCollections = sortedCollections;

        list = new Array<CollectionDefinition>();
    }

    public function add(bitfield:Bitfield, sorter:Entity->Entity->Int, name:String = "")
        list.push(new CollectionDefinition(bitfield, sorter, name));

    public function map()
    {
        for (definition in list)
            mapCollection(definition);
    }

        function mapCollection(definition:CollectionDefinition)
        {
            var config = collectionMap.mapBitfield(definition.bitfield);
            definition.collection = config.getCollection();
            configureSort(definition.collection, definition.sorter);
            injector.mapValue(Collection, definition.collection, definition.name);
        }

            function configureSort(collection:Collection, sorter:Entity->Entity->Int)
            {
                if (sorter != null)
                    sortedCollections.add(new CollectionSort(untyped collection.list.list, sorter));
            }

    public function unmap()
    {
        for (definition in list)
            injector.unmap(Collection, definition.name);
    }

}
