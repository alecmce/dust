package dust.gui.data;

import flash.geom.ColorTransform;

// FIXME for OpenGL rendering, makes more sense it's stored internally as floats
class Color
{
    var red:Float;
    var green:Float;
    var blue:Float;
    public var alpha:Float;

    public function new(rgb:Int = 0, alpha:Float = 1.0)
    {
        set(rgb, alpha);
    }

    inline public function set(rgb:Int = 0, alpha:Float = 1.0):Color
    {
        this.red =   ((rgb >> 16) & 0xFF) / 0xFF;
        this.green = ((rgb >> 8) & 0xFF)  / 0xFF;
        this.blue =  ((rgb >> 0) & 0xFF)  / 0xFF;
        this.alpha = alpha;
        return this;
    }

    inline public function getRed():Float
    {
        return red;
    }

    inline public function setRed(red:Float):Color
    {
        this.red = red;
        return this;
    }

    inline public function getGreen():Float
    {
        return green;
    }

    inline public function setGreen(green:Float):Color
    {
        this.green = green;
        return this;
    }

    inline public function getBlue():Float
    {
        return blue;
    }

    inline public function setBlue(blue:Float):Color
    {
        this.blue = blue;
        return this;
    }

    inline public function getAlpha():Float
    {
        return alpha;
    }

    inline public function setAlpha(alpha:Float):Color
    {
        this.alpha = alpha;
        return this;
    }

    public function getRGB():Int
    {
        var R = Std.int(red * 0xFF);
        var G = Std.int(green * 0xFF);
        var B = Std.int(blue * 0xFF);
        return (R << 16) | (G << 8) | B;
    }

    public function getWhiteTransform(alpha:Float = 1.0):ColorTransform
    {
        var r = getRed() / 0xFF;
        var g = getGreen() / 0xFF;
        var b = getBlue() / 0xFF;
        return new ColorTransform(red, green, blue, alpha);
    }

    public function getBlackTransform(alpha:Float = 1.0):ColorTransform
    {
        var A = Std.int(alpha * 0xFF);
        var R = Std.int(red * 0xFF);
        var G = Std.int(green * 0xFF);
        var B = Std.int(blue * 0xFF);

        return new ColorTransform(1, 1, 1, A, R, G, B);
    }

    public function clone():Color
    {
        var other = new Color();
        other.red = red;
        other.green = green;
        other.blue = blue;
        other.alpha = alpha;
        return other;
    }

    public function toString():String
    {
        var rgb = StringTools.hex(getRGB());
        return '[rgb=#$rgb, alpha=$alpha]';
    }
}