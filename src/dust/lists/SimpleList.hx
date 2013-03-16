package dust.lists;

import dust.lists.LinkedListItem;

class SimpleList<T> extends LinkedList<T>
{
    public static function make<T>():SimpleList<T>
        return new SimpleList<T>()

    public function new()
    {
        super();
        itemProvider = makeItem;
    }

    inline function makeItem(data:T):LinkedListItem<T>
    {
        var item = new LinkedListItem();
        item.data = data;
        return item;
    }
}
