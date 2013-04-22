package dust.multitouch.control;

import dust.multitouch.data.Touch;
class Touches
{
    var list:Array<Touch>;
    var hash:IntHash<Touch>;
    var count:Int;

    public function new()
    {
        list = new Array<Touch>();
        hash = new IntHash<Touch>();
        count = 0;
    }

    inline public function add(touch:Touch)
    {
        list.push(touch);
        hash.set(touch.id, touch);
        ++count;
    }

    inline public function remove(touch:Touch)
    {
        list.remove(touch);
        hash.remove(touch.id);
        --count;
    }

    inline public function getByIndex(index:Int):Touch
        return list[index]

    inline public function has(id:Int):Bool
        return hash.exists(id)

    inline public function get(id:Int):Touch
        return hash.get(id)

    inline public function getCount():Int
        return count

    public function iterator():Iterator<Touch>
        return list.iterator()
}
