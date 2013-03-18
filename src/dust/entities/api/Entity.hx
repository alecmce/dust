package dust.entities.api;

import dust.components.Bitfield;
import dust.components.Component;
import dust.lists.Pool;

class Entity
{
	public var id:Int;
    var bitfield:Bitfield;

    public var isChanged:Bool;
    public var isReleased:Bool;
    var components:IntHash<Component>;
    var deleted:Array<Int>;

	public function new(id:Int, bitfield:Bitfield)
	{
		this.id = id;
        this.bitfield = bitfield;

        isChanged = false;
        isReleased = false;
        components = new IntHash<Component>();
        deleted = new Array<Int>();
    }

    inline public function add(component:Component, ?asType:Class<Component> = null):Bool
	{
        var componentID = asType == null ? component.componentID : (cast asType).ID;
		var isNewComponent = !components.exists(componentID);
		if (isNewComponent)
		    addComponent(componentID, component);
		return isNewComponent;
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
        for (componentID in components.keys())
            deleted.push(componentID);
    }

    inline public function update()
    {
        for (componentID in deleted)
            components.remove(componentID);
        untyped deleted.length = 0;
        isChanged = false;
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
