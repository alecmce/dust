package dust.entities;

import dust.interactive.data.Offsets;
import dust.entities.Entity;
import dust.components.Bitfield;
import dust.lists.Pool;
import dust.type.TypeIndex;

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

    inline public function add(component:Dynamic)
        addComponent(TypeIndex.getInstanceID(component), component);

    inline public function addAsType(component:Dynamic, asType:Class<Dynamic>)
        addComponent(TypeIndex.getClassID(asType), component);

        inline function addComponent(componentID:Int, component:Dynamic)
        {
            components.set(componentID, component);
            bitfield.assert(componentID);
            isChanged = true;
        }

    public function remove<T>(type:Class<T>):Bool
        return removeComponentWithID(TypeIndex.getClassID(type));

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

    inline public function get<T>(type:Class<T>):T
		return cast components.get(TypeIndex.getClassID(type));

    inline public function has<T>(type:Class<T>):Bool
        return bitfield.get(TypeIndex.getClassID(type));

	inline public function iterator():Iterator<Dynamic>
		return components.iterator();

    public function toString():String
        return '[Entity $id (${bitfield.toString()})]';
}
