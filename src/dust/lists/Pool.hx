package dust.lists;

using Lambda;

class Pool<T>
{
    var factory:Void->T;
    var count:Int;
    var list:Array<T>;
    var index:Int;

    public function new(factory:Void->T)
    {
        this.factory = factory;
        list = new Array<T>();
        index = 0;
        count = 0;
    }

    inline public function populate(count:Int)
    {
        var delta = count - this.count;
        if (delta > 0)
            makeNewItems(delta);
    }

        inline function makeNewItems(delta:Int)
        {
            count += delta;
            for (i in 0...delta)
                list.push(factory());
        }

    inline public function require():T
    {
        if (areAllRequired())
            makeNewItem();

        return getItem();
    }

        inline function areAllRequired():Bool
        {
            return index == count;
        }

        inline function makeNewItem():T
        {
            var item:T = factory();
            count = list.push(item);
            return item;
        }

        inline function getItem():T
        {
            return list[index++];
        }

    inline public function release(item:T)
    {
        var i = list.indexOf(item);
        var other = list[--index];
        list[index] = item;
        list[i] = other;
    }

    inline public function iterator():Iterator<T>
    {
        return list.iterator();
    }
}
