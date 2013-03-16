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

    public static function flatten<T>(list:Array<T>):Array<T>
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
