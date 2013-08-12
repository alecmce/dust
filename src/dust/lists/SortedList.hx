package dust.lists;

import dust.lists.LinkedListItem;
import dust.lists.LinkedList;

class SortedList<T>
{
    var list:LinkedList<T>;
    var sorter:T->T->Int;

    public function new(list:LinkedList<T>, sorter:T->T->Int)
    {
        this.list = list;
        this.sorter = sorter;
    }

    public function add(data:T)
    {
        var item = list.head;
        while (item != null)
        {
            if (sorter(item.data, data) <= 0)
                item = item.next;
            else
                break;
        }

        if (item != null)
            insertBefore(data, item);
        else
            list.append(data);
    }

        inline function insertBefore(data:T, item:LinkedListItem<T>)
        {
            item.prefix(list.itemProvider(data));
            if (item == list.head)
                list.head = item.prev;
        }

    public function remove(data:T):T
    {
        list.remove(data);
        return data;
    }

    public function iterator():Iterator<T>
    {
        return list.iterator();
    }
}
