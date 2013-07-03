package dust.entities.impl;

import dust.entities.impl.EntityList;
import dust.entities.api.Entity;
import dust.lists.SimpleList;
import dust.lists.LinkedListItem;
import dust.lists.LinkedList;

class EntityList
{
    public var list:LinkedList<Entity>;
    public var hash:IntHash<LinkedListItem<Entity>>;
    public var count:Int;

    public function new(list:LinkedList<Entity>)
    {
        this.list = list;
        hash = new IntHash<LinkedListItem<Entity>>();
    }

    public function has(entity:Entity):Bool
        return hash.exists(entity.id);

    public function add(entity:Entity)
    {
        var item = list.itemProvider(entity);
        list.appendItem(item);
        hash.set(entity.id, item);
        ++count;
    }

    public function remove(entity:Entity)
    {
        var id = entity.id;
        var item = hash.get(id);
        hash.remove(id);
        list.detachNodeFromList(item);
        --count;
    }

    public function iterator():Iterator<Entity>
        return list.iterator();
}