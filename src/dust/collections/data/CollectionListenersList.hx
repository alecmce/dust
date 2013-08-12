package dust.collections.data;

import dust.collections.api.CollectionListeners;
import dust.entities.Entity;

class CollectionListenersList
{
    var list:Array<CollectionListeners>;

    public function new(list:Array<CollectionListeners>)
    {
        this.list = list;
    }

    public function add(listeners:CollectionListeners)
    {
        list.push(listeners);
    }

    public function remove(listeners:CollectionListeners)
    {
        list.remove(listeners);
    }

    public function onEntityAdded(entity:Entity)
    {
        for (listener in list)
            listener.onEntityAdded(entity);
    }

    public function onEntityRemoved(entity:Entity)
    {
        for (listener in list)
            listener.onEntityRemoved(entity);
    }
}
