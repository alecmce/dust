package dust.collections.api;

import dust.components.Bitfield;
import dust.entities.Entity;
import dust.entities.EntityList;
import dust.lists.LinkedList;
import dust.lists.LinkedListItem;
import dust.lists.PooledList;
import dust.lists.SimpleList;
import dust.signals.Signal;

class Collection
{
    static var ID:Int = 0;
    public var id(default, null):Int;

    public var bitfield:Bitfield;
    public var list:EntityList;
    var onAdded:Entity->Void;
    var onRemoved:Entity->Void;

    public function new(bitfield:Bitfield, list:EntityList, onAdded:Entity->Void, onRemoved:Entity->Void)
    {
        id = ++ID;

        this.bitfield = bitfield;
        this.list = list;
        this.onAdded = onAdded;
        this.onRemoved = onRemoved;
    }

    inline public function has(entity:Entity):Bool
        return list.has(entity);

    inline public function meetsRequirements(entity:Entity):Bool
        return entity.satisfies(bitfield);

    inline public function add(entity:Entity)
    {
        list.add(entity);
        onAdded(entity);
    }

    inline public function remove(entity:Entity)
    {
        list.remove(entity);
        onRemoved(entity);
    }

    inline public function getCount():Int
        return list.count;

    inline public function iterator():Iterator<Entity>
        return list.iterator();

    public function toString():String
        return "[Collection id=" + id + " bits=(" + bitfield.toString() + ")] count=" + list.count + "]";
}
