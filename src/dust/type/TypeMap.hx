package dust.type;

#if macro
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;
#end

class TypeMap
{
    public var storage:Map<Int, Dynamic>;

    public function new()
        storage = new Map<Int, Dynamic>();

    macro public function add(self:ExprOf<TypeMap>, component:Expr):Expr
        return macro $self.storage.set(TypeIndex.getInstanceID($component, '${self.pos}'), $component);

    macro public function addAsType(self:ExprOf<TypeMap>, component:Expr, type:Expr)
        return macro $self.storage.set(TypeIndex.getClassID($type, '${self.pos}'), $component);

    macro public function exists(self:ExprOf<TypeMap>, component:Expr):Expr
        return macro $self.storage.exists(TypeIndex.getClassID($component, '${self.pos}'));

    macro public function get(self:ExprOf<TypeMap>, component:Expr):Expr
        return macro $self.storage.get(TypeIndex.getClassID($component, '${self.pos}'));

    macro public function remove(self:ExprOf<TypeMap>, component:Expr):Expr
        return macro $self.storage.remove(TypeIndex.getClassID($component, '${self.pos}'));
}
