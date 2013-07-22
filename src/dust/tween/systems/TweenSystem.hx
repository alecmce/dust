package dust.tween.systems;

import dust.tween.data.Tweens;
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
            var tweens:Tweens = entity.get(Tweens);

            for (tween in tweens)
            {
                tween.update(entity, deltaTime);
                if (tween.isComplete())
                {
                    tweens.remove(tween);
                    tween.onComplete(entity);
                }
            }

            if (tweens.getCount() == 0)
                entity.remove(Tweens);
        }
}