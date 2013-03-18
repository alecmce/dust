package dust.lists;

import dust.lists.LinkedList;
import dust.lists.LinkedListItem;

class LinkedList<T>
{
    public var head:LinkedListItem<T>;
    public var tail:LinkedListItem<T>;
    public var itemProvider:T->LinkedListItem<T>;

    public function new(itemProvider:T->LinkedListItem<T>)
        this.itemProvider = itemProvider

    inline public function append(data:T)
        appendItem(itemProvider(data))

    inline public function appendItem(item:LinkedListItem<T>)
        hasItem() ? appendToTail(item) : setFirstItem(item)

    inline public function prefix(data:T)
        prefixItem(itemProvider(data))

    inline public function prefixItem(item:LinkedListItem<T>)
        hasItem() ? prefixToHead(item) : setFirstItem(item)

        inline function hasItem():Bool
            return tail != null

        inline function prefixToHead(item:LinkedListItem<T>)
            prefixItemToHead(item)

        inline function prefixItemToHead(item:LinkedListItem<T>)
        {
            head.prev = item;
            item.next = head;
            head = item;
        }

        inline function appendToTail(item:LinkedListItem<T>)
            appendItemToTail(item)

        inline function appendItemToTail(item:LinkedListItem<T>)
        {
            tail.next = item;
            item.prev = tail;
            tail = item;
        }

        inline function setFirstItem(item:LinkedListItem<T>)
            head = tail = item

    public function remove(data:T)
    {
        var node = head;
        while (node != null)
        {
            if (node.data == data)
            {
                detachNodeFromList(node);
                node = null;
            }
            else
            {
                node = node.next;
            }
        }
    }

        inline public function detachNodeFromList(item:LinkedListItem<T>)
        {
            item.detach();
            if (head == item) head = item.next;
            if (tail == item) tail = item.prev;
        }

    public function iterator():Iterator<T>
        return new LinkedListIterator<T>(head)
}
