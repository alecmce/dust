package dust.entities.api;

import dust.components.Bitfield;
import dust.components.Component;
import dust.entities.impl.CollectionConnector;
import dust.lists.Pool;

class Entity
{
	static var ID:Int = 0;
	public var id(default, null):Int;

    var entities:Entities;
    var bitfield:Bitfield;
    var collectionConnector:CollectionConnector;
    var components:IntHash<Component>;

	public function new(entities:Entities, bitfield:Bitfield, collectionConnector:CollectionConnector)
	{
		id = ++ID;
        this.entities = entities;
        this.bitfield = bitfield;
        this.collectionConnector = collectionConnector;
        this.components = new IntHash<Component>();
    }

    inline public function add(component:Component, ?asType:Class<Component> = null):Bool
	{
        var componentID = asType == null ? component.componentID : (cast asType).ID;

		var isNewComponent = !components.exists(componentID);
		if (isNewComponent)
		{
            components.set(componentID, component);
            bitfield.set(componentID, true);
            collectionConnector.updateCollectionsOnComponentAdded(componentID, this);
		}
		
		return isNewComponent;
	}

    inline public function remove<T>(type:Class<T>):Bool
	{
        return removeComponentWithID(cast(type).ID);
    }

        inline function removeComponentWithID(componentID:Int):Bool
        {
            var isExistingComponent = components.exists(componentID);
            if (isExistingComponent)
            {
                bitfield.set(componentID, false);
                collectionConnector.updateCollectionsOnComponentRemoved(componentID, this);
                components.remove(componentID);
            }

            return isExistingComponent;
        }

    inline public function satisfies(collectionBitfield:Bitfield):Bool
    {
        return bitfield.isSubset(collectionBitfield);
    }

    inline public function dispose()
    {
        removeAll();
        entities.release(this);
    }

    inline public function removeAll()
    {
        for (id in components.keys())
            removeComponentWithID(id);
    }

    inline public function get<T>(type:Class<T>):T
		return cast(components.get(cast(type).ID))

    inline public function has(type:Class<Dynamic>):Bool
		return components.exists(cast(type).ID)

	inline public function iterator():Iterator<Component>
		return components.iterator()

    public function toString():String
        return "[Entity " + id + " (" + bitfield.toString() + ")]"
}
