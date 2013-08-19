package dust;

class IntUtil
{
    public static function toFixed(value:Int, figures:Int):String
    {
        var str = Std.string(value);
        var i = figures - str.length;
        if (i > 0) while (i-- > 0)
            str = "0" + str;
        else if (i < 0)
            return str.substr(0, figures);

        return str;
    }
}
