package dust.systems.impl;

import dust.lists.LinkedList;
import dust.entities.Entity;
import dust.entities.EntityList;

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
