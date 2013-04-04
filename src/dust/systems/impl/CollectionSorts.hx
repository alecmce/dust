package dust.systems.impl;

class CollectionSorts
{
    var list:Array<CollectionSort>;

    public function new()
        list = new Array<CollectionSort>()

    public function add(sort:CollectionSort)
        list.push(sort)

    public function iterator():Iterator<CollectionSort>
        return list.iterator()
}
