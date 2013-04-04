package dust.systems.impl;

import dust.lists.LinkedList;
import dust.entities.api.Entity;
import dust.entities.impl.EntityList;

class CollectionSort
{
    public var list:LinkedList<Entity>;
    public var sorter:Entity->Entity->Int;

    public function new(list:LinkedList<Entity>, sorter:Entity->Entity->Int)
    {
        this.list = list;
        this.sorter = sorter;
    }
}
