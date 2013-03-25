package dust.math;

import Array;
class Random
{
    public var seed:Int;

    public function new(seed:Int = 0)
    {
        this.seed = seed == 0 ? Std.int(Math.random() * 2147483647) : seed;
    }

    inline public function bool(chance:Float = 0.5):Bool
    {
        return next() < chance * 2147483647;
    }

    inline public function int(range:Int):Int
    {
        return next() % range;
    }

    inline public function intInRange(min:Int, max:Int):Int
    {
        return min + int(max - min);
    }

    inline public function float(range:Float = 1.0):Float
    {
        var value = range * (next() / 2147483647);
        return range * (next() / 2147483647);
    }

    inline public function floatInRange(min:Float, max:Float):Float
    {
        return min + float(max - min);
    }

    inline public function from<T>(array:Array<T>):T
    {
        return array[int(array.length)];
    }

    inline public function color():Int
    {
        return (int(0xFF) << 16) | (int(0xFF) << 8) | int(0xFF);
    }

    inline function next():Int
    {
        var value = seed;
        seed = (seed * 16807) % 2147483647;
        if (seed < 0)
            seed += 2147483647;
        return value;
    }
}

