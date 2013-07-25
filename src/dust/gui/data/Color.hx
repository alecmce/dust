package dust.gui.data;

import flash.geom.ColorTransform;

class Color
{
    public var rgb:Int;
    public var alpha:Float;

    public function new(rgb:Int = 0, alpha:Float = 1.0)
    {
        set(rgb, alpha);
    }

    inline public function set(rgb:Int = 0, alpha:Float = 1.0):Color
    {
        this.rgb = rgb;
        this.alpha = alpha;
        return this;
    }

    inline public function getRed():Int
    {
        return rgb >> 16;
    }

    inline public function setRed(red:Int):Color
    {
        rgb = (rgb & 0x00FFFF) | (red << 16);
        return this;
    }

    inline public function getGreen():Int
    {
        return (rgb >>  8) & 0xFF;
    }

    inline public function setGreen(green:Int):Color
    {
        rgb = (rgb & 0xFF00FF) | (green << 8);
        return this;
    }

    inline public function getBlue():Int
    {
        return rgb & 0xFF;
    }

    inline public function setBlue(blue:Int):Color
    {
        rgb = (rgb & 0xFFFF00) | blue;
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

    public function getWhiteTransform(alpha:Float = 1.0):ColorTransform
    {
        var r = getRed() / 0xFF;
        var g = getGreen() / 0xFF;
        var b = getBlue() / 0xFF;
        return new ColorTransform(r, g, b, alpha);
    }

    public function getBlackTransform(alpha:Float = 1.0):ColorTransform
    {
        return new ColorTransform(1, 1, 1, alpha, getRed(), getGreen(), getBlue());
    }

    public function toString():String
    {
        return "[rgb=#" + StringTools.hex(rgb) + ", alpha=" + alpha + "]";
    }
}