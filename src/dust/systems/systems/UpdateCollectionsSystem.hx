package dust.systems.systems;

import dust.collections.control.CollectionSubscriber;
import dust.collections.data.CollectionList;
import dust.entities.Entity;
import dust.entities.Entities;
import dust.systems.System;

class UpdateCollectionsSystem implements System
{
    @inject public var entities:Entities;
    @inject public var collections:CollectionList;
    @inject public var subscriber:CollectionSubscriber;

    public function start() {}
    
    public function stop()
        iterate(0);

    public function iterate(deltaTime:Float)
    {
        for (entity in entities)
            updateEntity(entity);
    }

        inline function updateEntity(entity:Entity)
        {
            if (entity.isChanged)
                processEntityChanges(entity);
        }

            inline function processEntityChanges(entity:Entity)
            {
                entity.cacheDeletions();
                subscriber.updateEntity(entity);
                entity.removeCachedDeletions();
                if (entity.isReleased)
                    releaseEntity(entity);
            }

                inline function releaseEntity(entity:Entity)
                {
                    entity.isReleased = false;
                    entities.release(entity);
                }
}
