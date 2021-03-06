package dust.entities;

import dust.pooling.data.Pooled;
import dust.entities.Entity;
import dust.bitfield.Bitfield;

#if macro
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;
#end

class Entity
{
	public var id:Int;
    public var bitfield:Bitfield;
    public var isChanged:Bool;
    public var isReleased:Bool;

    public var onReleased:Entity->Void;

    var components:Array<Dynamic>;
    var deleted:Array<Int>;
    var cached:Array<Int>;

	public function new(id:Int, bitfield:Bitfield)
	{
		this.id = id;
        this.bitfield = bitfield;
        this.isChanged = false;
        this.isReleased = false;

        components = new Array<Dynamic>();
        deleted = new Array<Int>();
        cached = new Array<Int>();
    }

    macro public function add(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getInstanceID($component, '${self.pos}');
        return macro @:privateAccess $self.addComponent($id, $component);
    }

    macro public function addAsType(self:ExprOf<Entity>, component:Expr, type:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($type, '${self.pos}');
        return macro @:privateAccess $self.addComponent($id, $component);
    }

        inline function addComponent(componentID:Int, component:Dynamic)
        {
            components[componentID] = component;
            bitfield.assert(componentID);
            isChanged = true;
        }

    macro public function remove(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component, '${self.pos}');
        return macro @:privateAccess $self.removeComponentWithID($id);
    }

        inline function removeComponentWithID(componentID:Int):Bool
        {
            var isExistingComponent = components[componentID] != null;
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
    {
        return bitfield.isSubset(collectionBitfield);
    }

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

        for (i in 0...components.length)
            if (components[i] != null)
                deleted.push(i);
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
            {
                var component = components[componentID];
                components[componentID] = null;

                if (Std.is(component, Pooled))
                    cast(component, Pooled).release();
            }
        }
        untyped cached.length = 0;
    }

    macro public function get(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component, '${self.pos}');
		return macro @:privateAccess $self.getComponent($id);
    }

        inline function getComponent<T>(index:Int):T
        {
            return cast components[index];
        }

    macro public function has(self:ExprOf<Entity>, component:Expr):Expr
    {
        var id = macro dust.type.TypeIndex.getClassID($component, '${self.pos}');
        return macro @:privateAccess $self.hasComponent($id);
    }

        inline function hasComponent(index:Int):Bool
        {
            return bitfield.get(index);
        }

	inline public function iterator():Iterator<Dynamic>
    {
        return components.iterator();
    }

    public function toString():String
    {
        return '[Entity $id (${bitfield.toString()})]';
    }
}
