package dust.collections.data;

import dust.collections.api.CollectionListeners;
import dust.entities.Entity;

class SimpleCollectionListeners implements CollectionListeners
{
    var listeners:Array<CollectionListeners>;

    public function new(listeners:Array<CollectionListeners>)
    {
        this.listeners = listeners;
    }

    public function onEntityAdded(entity:Entity)
    {
        for (listener in listeners)
            listener.onEntityAdded(entity);
    }

    public function onEntityRemoved(entity:Entity)
    {
        for (listener in listeners)
            listener.onEntityRemoved(entity);
    }
}
