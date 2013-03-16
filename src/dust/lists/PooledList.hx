package dust.lists;

import dust.lists.LinkedListItem;
import dust.lists.LinkedList;

class PooledList<T> extends LinkedList<T>
{
    var pool:Pool<LinkedListItem<T>>;
    var dataProvider:Void->T;

    public function new()
    {
        super();
        pool = new Pool<LinkedListItem<T>>(makeLinkedListItem);
        itemProvider = make;
    }

        function makeLinkedListItem():LinkedListItem<T>
        {
            return new LinkedListItem<T>();
        }

        inline function make(data:T):LinkedListItem<T>
        {
            var item = pool.require();
            item.data = data;
            return item;
        }

    public function populate(count:Int)
    {
        pool.populate(count);
    }
}
