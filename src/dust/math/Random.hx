package dust.math;

import Array;

class Random
{
    inline static var MODULUS = 2147483647;
    inline static var MULTIPLIER = 16807;

    public var seed:Int;

    public function new(seed:Int = 0)
    {
        this.seed = seed == 0 ? Std.int(Math.random() * MODULUS) : seed;
    }

    inline public function bool(chance:Float = 0.5):Bool
    {
        return next() < chance * MODULUS;
    }

    inline public function int(range:Int):Int
    {
        return Std.int(float(range));
    }

    inline public function intInRange(min:Int, max:Int):Int
    {
        return min + int(max - min);
    }

    inline public function float(range:Float = 1.0):Float
    {
        return range * (next() / MODULUS);
    }

    inline public function floatInRange(min:Float, max:Float):Float
    {
        return min + float(max - min);
    }

    inline public function fromArray<T>(array:Array<T>):T
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
        seed = (seed * MULTIPLIER) % MODULUS;
        if (seed < 0)
            seed += MODULUS;
        return value;
    }
}

