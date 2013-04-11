package dust.components;

class Bitfield
{	
	inline static var BITS = 31;

	public var size(default, null):Int;

	var dimension:Int;
	var bits:Array<Int>;

	public function new(dimension:Int)
	{
        if (dimension == 0)
            throw new ZeroBitfieldDimensionError();

		this.dimension = dimension;
		this.size = dimension << 5;
		bits = new Array<Int>();

		for (i in 0...dimension)
			bits.push(0);
	}

	inline public function get(index:Int):Bool
	{
		return ((bits[index >> 5] & (1 << (index & BITS))) >> (index & BITS)) != 0;
	}

    inline public function set(index:Int, flag:Bool):Void
	{
        flag ? assert(index) : clear(index);
	}

    inline public function assert(index:Int):Void
	{
		var i = index >> 5;
		bits[i] = bits[i] | (1 << (index & BITS));
    }

    inline public function clear(index:Int):Void
	{
		var i = index >> 5;
		bits[i] = bits[i] & (~(1 << (index & BITS)));
	}

    inline public function reset():Void
	{
		for (i in 0...dimension)
			bits[i] = 0;
	}

    inline public function isSubset(subset:Bitfield):Bool
	{
        var subsetBits = subset.bits;
		var isSubset = true;
        for (i in 0...dimension)
        {
            isSubset = (~bits[i] & subsetBits[i]) == 0;
            if (!isSubset)
                break;
        }
		
		return isSubset;
	}

    public function clone():Bitfield
    {
        var cloned = new Bitfield(dimension);
        var clonedBits = cloned.bits;
        for (i in 0...dimension)
            clonedBits[i] = bits[i];
        return cloned;
    }

    inline public function intersect(bitfield:Bitfield)
    {
        var otherBits = bitfield.bits;
        for (i in 0...dimension)
            bits[i] = bits[i] & otherBits[i];
    }
	
	inline public function union(bitfield:Bitfield)
	{
		var otherBits = bitfield.bits;
		for (i in 0...dimension)
			bits[i] = bits[i] | otherBits[i];
	}

	public function toString():String
	{
		var arr = new Array<String>();
		for (i in 0...size)
            arr.unshift(get(i) ? '1' : '0');
		return arr.join("");
	}

    public function iterator():Iterator<Int>
    {
        return makeFlags().iterator();
    }

        inline function makeFlags():Array<Int>
        {
            var flags = new Array<Int>();
            for (i in 0...size)
                if (get(i)) flags.push(i);
            return flags;
        }

}

class ZeroBitfieldDimensionError
{
    public function new() {}
}