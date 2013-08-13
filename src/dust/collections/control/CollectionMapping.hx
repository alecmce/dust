package dust.collections.control;

import dust.collections.data.CollectionListenersList;
import dust.collections.data.CollectionList;
import dust.collections.api.Collection;
import dust.collections.api.CollectionListeners;
import dust.bitfield.Bitfield;
import dust.entities.Entity;
import dust.entities.EntityList;
import dust.lists.SimpleList;

import dust.Injector;

class CollectionMapping
{
    function emptyMethod(entity:Entity) {}

    var injector:Injector;
    var bitfield:Bitfield;
    var collectionList:CollectionList;
    var subscriber:CollectionSubscriber;
    var listenersMap:CollectionListenersMap;

    var instance:Collection;
    var listeners:CollectionListenersList;
    var components:Array<Class<Dynamic>>;

    public function new(parent:Injector, bitfield:Bitfield, collectionList:CollectionList, subscriber:CollectionSubscriber)
    {
        injector = new Injector(parent);

        this.bitfield = bitfield;
        this.collectionList = collectionList;
        this.subscriber = subscriber;
        this.listenersMap = new CollectionListenersMap(injector);

        injector.mapValue(CollectionListenersMap, listenersMap);
    }

    public function setComponents(components:Array<Class<Dynamic>>):CollectionMapping
    {
        this.components = components;
        return this;
    }

    public function toListeners(listener:Class<CollectionListeners>):CollectionMapping
    {
        listenersMap.addListener(listener);
        if (instance != null)
            lazilyAddListeners(listener);
        return this;
    }

        function lazilyAddListeners(listener:Class<CollectionListeners>)
        {
            var listener:CollectionListeners = cast injector.instantiate(listener);
            listeners.add(listener);
            for (entity in instance)
                listener.onEntityAdded(entity);
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
            collectionList.append(collection);
            populateCollection(collection);
            return collection;
        }

            function makeCollection():Collection
            {
                var list = new EntityList(new SimpleList<Entity>());
                listeners = listenersMap.make();
                return new Collection(bitfield, list, listeners.onEntityAdded, listeners.onEntityRemoved);
            }

        function populateCollection(collection:Collection)
        {
            subscriber.updateCollection(collection);
        }

    public function dispose()
    {
        if (instance != null)
        {
            listeners.clear();
            instance = null;
        }
    }
}