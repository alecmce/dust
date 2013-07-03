package dust.type;

import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class TypeMap
{
    public var storage:Map<Int, Dynamic>;

    public function new()
    {
        storage = new Map<Int, Dynamic>();
    }

    macro public function add(self:ExprOf<TypeMap>, component:Expr):Expr
    {
        return macro $self.storage.set(TypeIndex.getInstanceID($component), $component);
    }

    macro public function exists(self:ExprOf<TypeMap>, component:Expr):Expr
    {
        return macro $self.storage.exists(TypeIndex.getClassID($component));
    }

    macro public function get(self:ExprOf<TypeMap>, component:Expr):Expr
    {
        return macro $self.storage.get(TypeIndex.getClassID($component));
    }

    macro public function remove(self:ExprOf<TypeMap>, component:Expr):Expr
    {
        return macro $self.storage.remove(TypeIndex.getClassID($component));
    }
}
