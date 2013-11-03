package dust.math.pure;

class ModInt
{
    public var value(default, set_value):Int;
    public var modulus:Int;

    public function new(value:Int, modulus:Int)
    {
        this.modulus = modulus;
        set_value(value);
    }

    function set_value(value:Int):Int
    {
        this.value = value % modulus;
        if (this.value < 0)
            this.value += modulus;
        return this.value;
    }
}
