package dust.systems.impl;

import dust.components.Component;
import dust.collections.api.Collection;

class CollectionDefinition
{
    public var collection:Collection;

    public var components:Array<Class<Component>>;
    public var name:String;

    public function new(components:Array<Class<Component>>, name:String = "")
    {
        this.components = components;
        this.name = name;
    }
}
