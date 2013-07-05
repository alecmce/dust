package dust.relations.data;

import dust.entities.Entity;

class Relation
{
    public var agent:Entity;
    public var object:Entity;

    public function new(agent:Entity, object:Entity)
    {
        this.agent = agent;
        this.object = object;
    }
}
