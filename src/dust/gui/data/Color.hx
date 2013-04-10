package dust.gui.data;

class Color
{
    public var rgb:Int;
    public var alpha:Float;

    public function new(rgb:Int = 0, alpha:Float = 1.0)
    {
        set(rgb, alpha);
    }

    inline public function set(rgb:Int = 0, alpha:Float = 1.0)
    {
        this.rgb = rgb;
        this.alpha = alpha;
    }

    inline public function getRed():Int
    {
        return rgb >> 16;
    }

    inline public function setRed(red:Int)
    {
        rgb = (rgb & 0x00FFFF) | (red << 16);
    }

    inline public function getGreen():Int
    {
        return (rgb >>  8) & 0xFF;
    }

    inline public function setGreen(green:Int)
    {
        rgb = (rgb & 0xFF00FF) | (green << 8);
    }

    inline public function getBlue():Int
    {
        return rgb & 0xFF;
    }

    inline public function setBlue(blue:Int)
    {
        rgb = (rgb & 0xFFFF00) | blue;
    }

    public function toString():String
    {
        return "[rgb=#" + StringTools.hex(rgb) + ", alpha=" + alpha + "]";
    }
}