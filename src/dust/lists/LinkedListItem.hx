package dust.lists;

class LinkedListItem<T>
{
    public var prev:LinkedListItem<T>;
    public var next:LinkedListItem<T>;

    public var data:T;

    public function new() {}

    inline public function prefix(item:LinkedListItem<T>)
    {
        item.prev = prev;
        item.next = this;
        prev = item;
    }

    inline public function append(item:LinkedListItem<T>)
    {
        item.next = next;
        item.prev = this;
        next = item;
    }

    inline public function detach()
    {
        if (next != null) next.prev = prev;
        if (prev != null) prev.next = next;
    }
}
