package dust.collections.data;

import dust.entities.api.Entity;

class CollectionSort
{
    public var sorter:Entity->Entity->Int;

    public function new(sorter:Entity->Entity->Int)
    {
        this.sorter = sorter;
    }
}
