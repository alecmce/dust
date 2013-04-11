package dust.components;

class BitfieldFactory
{
    public var dimension:Int;

    public function new()
    {
        dimension = 2;
    }

    public function makeEmpty():Bitfield
    {
        return new Bitfield(dimension);
    }

    public function make(components:Array<Class<Component>>):Bitfield
    {
        var bitfield = new Bitfield(dimension);
        for (component in components)
        {
            var id = (cast component).ID;
            bitfield.assert(id);
            trace(bitfield.toString() + ' - ' + id + ' - ' + component);
        }
        return bitfield;
    }
}