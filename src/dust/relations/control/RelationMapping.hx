package dust.relations.control;

import dust.systems.impl.SystemMapping;

class RelationMapping
{
    var systemMapping:SystemMapping;

    public function new(systemMapping:SystemMapping)
    {
        this.systemMapping = systemMapping;
    }

    public function toAgent(collection:Array<Class<Dynamic>>):RelationMapping
    {
        return this;
    }

    public function toObject(collection:Array<Class<Dynamic>>):RelationMapping
    {
        return this;
    }

    public function withName():RelationMapping
    {
        return this;
    }
}
