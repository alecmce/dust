package dust.lists;

import dust.lists.LinkedListItem;

class LinkedListIterator<T>
{
    var item:LinkedListItem<T>;

    public function new(head:LinkedListItem<T>)
    {
        item = new LinkedListItem<T>();
        item.next = head;
    }

    public function hasNext():Bool
    {
        return item.next != null;
    }

    public function next():T
    {
        item = item.next;
        return item.data;
    }
}
