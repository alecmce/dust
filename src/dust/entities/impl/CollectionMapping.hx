package dust.entities.impl;

import dust.entities.impl.CollectionSort;
import dust.entities.api.Collection;
import dust.entities.impl.CollectionConnector;
import dust.entities.api.CollectionListeners;
import dust.entities.impl.CollectionListenersMap;
import dust.commands.Command;
import dust.components.Bitfield;
import dust.components.Component;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.impl.EntityList;
import dust.entities.impl.SimpleEntityList;
import dust.entities.impl.SortedEntityList;
import dust.lists.LinkedList;
import dust.lists.SimpleList;

import minject.Injector;

class CollectionMapping
{
    function emptyMethod(entity:Entity) {}

    var injector:Injector;
    var bitfield:Bitfield;
    var entities:Entities;
    var collectionConnector:CollectionConnector;
    var listenersMap:CollectionListenersMap;

    var instance:Collection;
    var components:Array<Class<Component>>;
    var sorter:Entity->Entity->Int;

    public function new(parent:Injector, bitfield:Bitfield, entities:Entities, collectionConnector:CollectionConnector)
    {
        injector = new Injector();
        injector.parentInjector = parent;

        this.bitfield = bitfield;
        this.entities = entities;
        this.collectionConnector = collectionConnector;
        this.listenersMap = new CollectionListenersMap(injector);

        injector.mapValue(CollectionListenersMap, listenersMap);
    }

    public function setComponents(components:Array<Class<Component>>):CollectionMapping
    {
        this.components = components;
        return this;
    }

    public function setSorter(sorter:Entity->Entity->Int):CollectionMapping
    {
        this.sorter = sorter;
        return this;
    }

    public function toListeners(listener:Class<CollectionListeners>):CollectionMapping
    {
        listenersMap.addListener(listener);
        return this;
    }

    public function getCollection():Collection
    {
        if (instance == null)
            instance = makeAndPopulateCollection();
        return instance;
    }

        function makeAndPopulateCollection():Collection
        {
            var collection = makeCollection();
            collectionConnector.addCollection(collection);
            populateCollection(collection);
            return collection;
        }

            function makeCollection():Collection
            {
                var list = makeList();
                var listeners = listenersMap.make();
                return new Collection(bitfield, list, listeners.onEntityAdded, listeners.onEntityRemoved);
            }

                function makeList():EntityList
                {
                    var list = makeLinkedList();
                    return if (sorter != null)
                        new SortedEntityList(list, sorter);
                    else
                        new SimpleEntityList(list);
                }

                    function makeLinkedList():LinkedList<Entity>
                    {
                        return new SimpleList<Entity>();
                    }

        function populateCollection(collection:Collection)
        {
            var collectionOnAdded = collection.add;
            for (entity in entities)
                collectionOnAdded(entity);
        }
}