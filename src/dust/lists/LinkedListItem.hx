package dust.lists;

class LinkedListItem<T>
{
    public var prev:LinkedListItem<T>;
    public var next:LinkedListItem<T>;

    public var data:T;

    public function new(?data:T)
        this.data = data;

    inline public function prefix(item:LinkedListItem<T>)
    {
        if (prev != null)
            prev.next = item;

        item.prev = prev;
        item.next = this;
        prev = item;
    }

    inline public function append(item:LinkedListItem<T>)
    {
        if (next != null)
            next.prev = item;

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
