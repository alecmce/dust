package dust.lists;

import dust.lists.LinkedListItem;

class SimpleList<T> extends LinkedList<T>
{
    public static function make<T>():SimpleList<T>
        return new SimpleList<T>()

    public function new()
        super(makeItem)

    inline function makeItem(data:T):LinkedListItem<T>
        return new LinkedListItem(data)
}
