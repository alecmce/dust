package dust.tween;

import dust.tween.data.Tweens;
import dust.tween.data.Tween;
import dust.entities.Entity;

class TweensUtil
{
    public static function addTween(entity:Entity, tween:Tween)
    {
        if (entity.has(Tweens))
            entity.get(Tweens).add(tween);
        else
            entity.add(new Tweens().add(tween));
    }

    public static function removeTween(entity:Entity, tween:Tween)
    {
        if (entity.has(Tweens))
        {
            var tweens:Tweens = entity.get(Tweens);
            tweens.remove(tween);
            if (tweens.getCount() == 0)
                entity.remove(Tweens);
        }
    }
}
