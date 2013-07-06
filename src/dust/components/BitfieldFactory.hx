package dust.components;

import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class BitfieldFactory
{
    public var dimension:Int;

    public function new()
        dimension = 3;

    public function makeEmpty():Bitfield
        return new Bitfield(dimension);

    macro public function make(self:ExprOf<BitfieldFactory>, components:Expr):Expr
    {
        var ids = macro dust.type.TypeIndex.getClassIDList($components);
        return macro $self.makeDefined($ids);
    }

    public function makeDefined(ids:Array<Int>):Bitfield
    {
        var bitfield = new Bitfield(dimension);
        for (id in ids)
            bitfield.assert(id);
        return bitfield;
    }
}