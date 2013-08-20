package dust.tween.data;

import dust.entities.Entity;

class Tween
{
    public var initial:Float;
    public var delta:Float;
    public var duration:Float;
    public var ease:Float->Float;
    public var onUpdate:Entity->Float->Void;
    public var onComplete:Entity->Void;
    public var delay:Float;

    public var value:Float;

    var progress:Float;
    var total:Float;
    var inverseDuration:Float;

    public function new(initial:Float, target:Float, duration:Float, delay:Float = 0.0)
    {
        this.initial = initial;
        this.delta = target - initial;
        this.duration = duration;
        this.ease = nullEase;
        this.onUpdate = nullUpdate;
        this.onComplete = nullComplete;
        this.delay = delay;
        reset();
    }

    inline public function reset()
    {
        this.progress = 0;
        this.value = initial;
        this.total = delay + duration;
        this.inverseDuration = 1 / duration;
    }

        function nullEase(proportion:Float):Float
            return proportion;

        function nullUpdate(entity:Entity, value:Float) {}
        function nullComplete(entity:Entity) {}

    public function setEase(ease:Float->Float):Tween
    {
        if (ease == null)
            ease = nullEase;

        this.ease = ease;
        return this;
    }

    public function setOnComplete(onComplete:Entity->Void):Tween
    {
        if (onComplete == null)
            onComplete = nullComplete;

        this.onComplete = onComplete;
        return this;
    }

    inline public function update(entity:Entity, deltaTime:Float)
    {
        progress += deltaTime;
        if (progress > delay)
        {
            if (progress > total)
                progress = total;

            var proportion = ease((progress - delay) * inverseDuration);
            value = initial + delta * proportion;
            onUpdate(entity, value);
        }
    }

    inline public function isComplete():Bool
    {
        return progress >= total;
    }
}
