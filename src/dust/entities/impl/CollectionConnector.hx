package dust.entities.impl;

import dust.entities.api.Collection;
import dust.entities.api.Entity;

class CollectionConnector
{
    var onAdded:IntHash<Array<Entity->Void>>;
    var onRemoved:IntHash<Array<Entity->Void>>;

    public function new()
    {
        onAdded = new IntHash<Array<Entity->Void>>();
        onRemoved = new IntHash<Array<Entity->Void>>();
    }

    public function addCollection(collection:Collection)
    {
        for (index in collection.requirements())
        {
            addToHash(onAdded, index, collection.add);
            addToHash(onRemoved, index, collection.remove);
        }
    }

    public function removeCollection(collection:Collection)
    {
        for (index in collection.requirements())
        {
            removeFromHash(onAdded, index, collection.add);
            removeFromHash(onRemoved, index, collection.remove);
        }
    }

    public function updateCollectionsOnComponentAdded(index:Int, entity:Entity)
    {
        var addedListeners = onAdded.get(index);
        if (addedListeners != null)
            callEntityHandlers(entity, addedListeners);
    }

    public function updateCollectionsOnComponentRemoved(index:Int, entity:Entity)
    {
        var removedListeners = onRemoved.get(index);
        if (removedListeners != null)
            callEntityHandlers(entity, removedListeners);
    }

    inline function addToHash(hash:IntHash<Array<Entity->Void>>, index:Int, fn:Entity->Void)
    {
        if (hash.exists(index))
            hash.get(index).push(fn);
        else
            hash.set(index, [fn]);
    }

    inline function removeFromHash(hash:IntHash<Array<Entity->Void>>, index:Int, fn:Entity->Void)
    {
        if (hash.exists(index))
            hash.get(index).remove(fn);
    }

    inline function callEntityHandlers(entity:Entity, handlers:Array<Entity->Void>)
    {
        for (fn in handlers)
            fn(entity);
    }
}
