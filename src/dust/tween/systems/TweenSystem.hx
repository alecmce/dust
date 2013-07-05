package dust.tween.systems;

import dust.tween.data.Tween;
import dust.entities.Entity;
import dust.systems.System;
import dust.collections.api.Collection;

class TweenSystem implements System
{
    @inject public var collection:Collection;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            updateEntity(entity, deltaTime);
    }

        inline function updateEntity(entity:Entity, deltaTime:Float)
        {
            var tween:Tween = entity.get(Tween);
            tween.update(entity, deltaTime);

            if (tween.isComplete())
            {
                entity.remove(Tween);
                tween.onComplete(entity);
            }
        }
}