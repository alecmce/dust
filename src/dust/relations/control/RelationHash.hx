package dust.relations.control;

import dust.entities.Entity;

class RelationHash
{
    var actorHash:IntHash<IntHash<Entity>>;

    public function new()
        actorHash = new IntHash<IntHash<Entity>>()

    public function set(actor:Entity, object:Entity, relation:Entity)
        getObjectHash(actor.id).set(object.id, relation)

        function getObjectHash(actor:Int):IntHash<Entity>
            return actorHash.exists(actor) ? actorHash.get(actor) : makeHash(actor)

            function makeHash(actor:Int):IntHash<Entity>
            {
                var objectHash = new IntHash<Entity>();
                actorHash.set(actor, objectHash);
                return objectHash;
            }

    public function get(actor:Entity, object:Entity):Entity
        return actorHash.exists(actor.id) ? actorHash.get(actor.id).get(object.id) : null

    public function remove(actor:Entity, object:Entity):Entity
        return actorHash.exists(actor.id) ? removeFromObjectHash(actor.id, object.id) : null

        function removeFromObjectHash(actor:Int, object:Int):Entity
        {
            var objectHash = actorHash.get(actor);
            var entity = objectHash.get(object);
            objectHash.remove(object);
            return entity;
        }
}
