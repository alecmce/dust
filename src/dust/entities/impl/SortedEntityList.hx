package dust.entities.impl;

import dust.entities.api.Entity;
import dust.lists.SortedList;
import dust.lists.SimpleList;
import dust.lists.LinkedListItem;
import dust.lists.LinkedList;

class SortedEntityList implements EntityList
{
    var sorted:SortedList<Entity>;
    var hash:IntHash<Entity>;

    public function new(list:LinkedList<Entity>, sorter:Entity->Entity->Int)
    {
        sorted = new SortedList<Entity>(list, sorter);
        hash = new IntHash<Entity>();
    }

    inline public function has(entity:Entity):Bool
    {
        return hash.exists(entity.id);
    }

    inline public function add(entity:Entity)
    {
        sorted.add(entity);
        hash.set(entity.id, entity);
    }

    inline public function remove(entity:Entity)
    {
        sorted.remove(entity);
        hash.remove(entity.id);
    }

    inline public function iterator():Iterator<Entity>
    {
        return sorted.iterator();
    }
}