package dust.systems.impl;

import dust.entities.api.Entity;
import dust.components.Component;
import dust.collections.api.Collection;

class CollectionDefinition
{
    public var collection:Collection;

    public var components:Array<Class<Component>>;
    public var sorter:Entity->Entity->Int;
    public var name:String;

    public function new(components:Array<Class<Component>>, sorter:Entity->Entity->Int, name:String = "")
    {
        this.components = components;
        this.sorter = sorter;
        this.name = name;
    }
}
