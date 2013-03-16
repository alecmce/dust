package dust;

class FloatUtil
{
    public static function toFixed(value:Float, precision:Int):String
    {
        var scalar = Math.pow(10, precision);

        var str = Std.string(Math.round(value * scalar) / scalar);
        var index = str.indexOf(".");
        if (index == -1)
        {
            if (precision == 0)
                return str;

            index = str.length;
            str += ".";
        }

        if (precision == 0)
            return str.substr(0, index);

        var dp = str.length - index;
        while (dp++ < precision + 1)
            str += "0";

        return str.substr(0, index + precision + 1);
    }
}
