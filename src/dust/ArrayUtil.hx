package dust;

import Std;

class ArrayUtil
{
    public static function compact<T>(list:Array<T>):Array<T>
    {
        var compacted = new Array<T>();
        for (item in list)
            if (item != null)
                compacted.push(item);
        return compacted;
    }

    public static function all<T>(list:Array<T>, method:T->Bool):Bool
    {
        var areAll = true;
        var i = list.length;
        while (areAll && i-- > 0)
            areAll = method(list[i]);
        return areAll;
    }

    public static function any<T>(list:Array<T>, method:T->Bool):Bool
    {
        var areAny = false;
        var i = list.length;
        while (!areAny && i-- > 0)
            areAny = method(list[i]);
        return areAny;
    }

    public static function flatten<T>(list:Array<Dynamic>):Array<T>
    {
        var flattened = new Array<T>();
        copyInto(list, flattened);
        return flattened;
    }

        static function copyInto<T>(source:Iterable<T>, into:Array<Dynamic>)
        {
            for (item in source)
            {
                if (Std.is(item, Array))
                    copyInto(cast item, into);
                else
                    into.push(item);
            }
        }
}
