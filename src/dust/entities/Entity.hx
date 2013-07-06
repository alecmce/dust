package dust.entities;

import dust.interactive.data.Offsets;
import dust.entities.Entity;
import dust.components.Bitfield;
import dust.lists.Pool;

import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class Entity
{
	public var id:Int;
    public var bitfield:Bitfield;
    public var isChanged:Bool;
    public var isReleased:Bool;

    var components:Map<Int, Dynamic>;
    var deleted:Array<Int>;
    var cached:Array<Int>;

	public function new(id:Int, bitfield:Bitfield)
	{
		this.id = id;
        this.bitfield = bitfield;

        isChanged = false;
        isReleased = false;
        components = new Map<Int, Dynamic>();
        deleted = new Array<Int>();
        cached = new Array<Int>();
    }

    macro public function add(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getInstanceID($component);
        return macro (untyped $self.addComponent)($id, $component);
    }

    macro public function addAsType(self:ExprOf<Entity>, component:Expr, type:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($type);
        return macro (untyped $self.addComponent)($id, $component);
    }
        
        inline function addComponent(componentID:Int, component:Dynamic)
        {
            components.set(componentID, component);
            bitfield.assert(componentID);
            isChanged = true;
        }

    macro public function remove(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component);
        return macro (untyped $self.removeComponentWithID)($id);
    }

        inline function removeComponentWithID(componentID:Int):Bool
        {
            var isExistingComponent = components.exists(componentID);
            if (isExistingComponent)
                markComponentAsRemoved(componentID);
            return isExistingComponent;
        }

            inline function markComponentAsRemoved(componentID:Int)
            {
                bitfield.clear(componentID);
                deleted.push(componentID);
                isChanged = true;
            }

    inline public function satisfies(collectionBitfield:Bitfield):Bool
        return bitfield.isSubset(collectionBitfield);

    inline public function dispose()
    {
        removeAll();
        isChanged = true;
        isReleased = true;
    }

    inline public function removeAll()
    {
        bitfield.reset();
        isChanged = true;
        for (componentID in components.keys())
            deleted.push(componentID);
    }

    inline public function cacheDeletions()
    {
        var swap = cached;
        cached = deleted;
        deleted = swap;
        isChanged = false;
    }

    inline public function removeCachedDeletions()
    {
        for (componentID in cached)
        {
            if (!bitfield.get(componentID))
                components.remove(componentID);
        }
        untyped cached.length = 0;
    }

    macro public function get(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component);
		return macro (untyped $self.components).get($id);
    }

    macro public function has(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component);
        return macro (untyped $self.bitfield).get($id);
    }

	inline public function iterator():Iterator<Dynamic>
		return components.iterator();

    public function toString():String
        return '[Entity $id (${bitfield.toString()})]';
}
