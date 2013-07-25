package dust;

class IntUtil
{
    public static function toFixed(value:Int, figures:Int):String
    {
        var str = Std.string(value);
        var i = figures - str.length;
        while (i-- > 0)
            str = "0" + str;
        return str;
    }
}
