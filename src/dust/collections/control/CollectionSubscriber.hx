package dust.collections.control;

import dust.entities.Entities;
import dust.collections.api.Collection;
import dust.collections.data.CollectionList;
import dust.entities.Entity;

class CollectionSubscriber
{
    @inject public var entities:Entities;
    @inject public var collections:CollectionList;

    public function new() {}

    public function updateEntity(entity:Entity)
    {
        for (collection in collections)
            updateSubscription(entity, collection);
    }

    public function updateCollection(collection:Collection)
    {
        for (entity in entities)
            updateSubscription(entity, collection);
    }

        inline function updateSubscription(entity:Entity, collection:Collection)
        {
            var isMember = collection.has(entity);
            var shouldBe = collection.meetsRequirements(entity);
            if (isMember != shouldBe)
                shouldBe ? collection.add(entity) : collection.remove(entity);
        }
}
