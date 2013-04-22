package dust.relations.control;

import dust.systems.impl.Systems;
import dust.systems.System;
import dust.relations.data.Relation;
import dust.entities.api.Entity;
import dust.entities.api.Entities;

class Relations
{
    @inject public var entities:Entities;
    @inject public var hash:RelationHash;
    @inject public var systems:Systems;

    public function require(actor:Entity, object:Entity):Entity
    {
        var entity = entities.require();
        entity.add(new Relation(actor, object));
        hash.set(actor, object, entity);
        return entity;
    }

    public function release(actor:Entity, object:Entity)
    {
        var entity = hash.remove(actor, object);
        if (entity != null)
            entity.dispose();
    }

    public function map(type:Class<System>, priority:Int = 0):RelationMapping
    {
        var mapping = systems.map(type, priority);
        return new RelationMapping(mapping);
    }
}
