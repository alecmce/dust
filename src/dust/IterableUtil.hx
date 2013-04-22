package dust;

class IterableUtil
{
    public static function first<T>(iterable:Iterable<T>, condition:T->Bool):T
    {
        for (data in iterable)
        {
            if (condition(data))
                return iterable;
        }

        return null;
    }

    public static function subset<T>(iterable:Iterable<T>, condition:T->Bool):Array<T>
    {
        var list = new Array<T>();
        for (data in iterable)
        {
            if (condition(data))
                list.push(data);
        }

        return list;
    }
}
