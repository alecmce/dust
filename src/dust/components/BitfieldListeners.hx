package dust.components;

import dust.lists.LinkedList;

class BitfieldListeners<T>
{
    var dimension:Int;
    var size:Int;
    var listeners:IntHash<LinkedList<T->Void>>;

    public function new(dimension:Int, listFactory:Void->LinkedList<T->Void>)
    {
        this.dimension = dimension;
        this.size = dimension * 32;
        makeListeners(listFactory);
    }

        function makeListeners(listFactory:Void->LinkedList<T->Void>)
        {
            this.listeners = new IntHash<LinkedList<T->Void>>();
            for (i in 0...size)
                listeners.set(i, listFactory());
        }

    public function add(bitfield:Bitfield, listener:T->Void)
    {
        for (index in bitfield)
            listeners.get(index).append(listener);
    }

    public function remove(bitfield:Bitfield, listener:T->Void)
    {
        for (index in bitfield)
            listeners.get(index).remove(listener);
    }

    public function dispatch(index:Int, data:T)
    {
        for (listener in listeners.get(index))
            listener(data);
    }
}
