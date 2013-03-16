package dust.entities.api;

import dust.components.Bitfield;
import dust.entities.api.Entity;
import dust.entities.impl.EntityList;
import dust.entities.impl.SimpleEntityList;
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
    var list:EntityList;
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

    public function add(entity:Entity)
    {
        if (!list.has(entity) && entity.satisfies(bitfield))
        {
            list.add(entity);
            onAdded(entity);
        }
    }

    public function remove(entity:Entity)
    {
        if (list.has(entity) && !entity.satisfies(bitfield))
        {
            list.remove(entity);
            onRemoved(entity);
        }
    }

    inline public function iterator():Iterator<Entity>
        return list.iterator()

    inline public function requirements():Iterator<Int>
        return bitfield.iterator()

    public function toString():String
        return "[Collection " + id + " (" + bitfield.toString() + ")]"
}
