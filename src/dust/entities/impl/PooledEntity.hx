package dust.entities.impl;

import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.components.Bitfield;
import dust.components.Component;
import dust.lists.Pool;

class PooledEntity implements Entity
{
	public var id:Int;
    public var isChanged:Bool;
    public var isReleased:Bool;
    
    var bitfield:Bitfield;
    var components:IntHash<Component>;
    var deleted:Array<Int>;
    var cached:Array<Int>;

	public function new(id:Int, bitfield:Bitfield)
	{
		this.id = id;
        this.bitfield = bitfield;

        isChanged = false;
        isReleased = false;
        components = new IntHash<Component>();
        deleted = new Array<Int>();
        cached = new Array<Int>();
    }

    inline public function add(component:Component)
	{
        var componentID = component.componentID;
        addComponent(componentID, component);
	}

    inline public function addAsType(component:Component, asType:Class<Component>)
    {
        var componentID = (cast asType).ID;
        addComponent(componentID, component);
    }

        inline function addComponent(componentID:Int, component:Component)
        {
            components.set(componentID, component);
            bitfield.set(componentID, true);
            isChanged = true;
        }

    inline public function remove<T>(type:Class<T>):Bool
        return removeComponentWithID(cast(type).ID)

        inline function removeComponentWithID(componentID:Int):Bool
        {
            var isExistingComponent = components.exists(componentID);
            if (isExistingComponent)
                markComponentAsRemoved(componentID);
            return isExistingComponent;
        }

            inline function markComponentAsRemoved(componentID:Int)
            {
                bitfield.set(componentID, false);
                deleted.push(componentID);
                isChanged = true;
            }

    inline public function satisfies(collectionBitfield:Bitfield):Bool
        return bitfield.isSubset(collectionBitfield)

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
            components.remove(componentID);
        untyped cached.length = 0;
    }

    inline public function get<T>(type:Class<T>):T
		return cast(components.get(cast(type).ID))

    inline public function has(type:Class<Dynamic>):Bool
        return bitfield.get(cast(type).ID)

	inline public function iterator():Iterator<Component>
		return components.iterator()

    public function toString():String
        return "[Entity " + id + " (" + bitfield.toString() + ")]"
}
