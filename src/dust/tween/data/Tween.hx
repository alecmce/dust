package dust.tween.data;

import dust.components.Component;

class Tween extends Component
{
    public var initial:Float;
    public var delta:Float;
    public var duration:Float;
    public var ease:Float->Float;
    public var delay:Float;

    public var value(default, null):Float;

    var progress:Float;
    var inverseDuration:Float;

    public function new(initial:Float, target:Float, duration:Float)
    {
        this.initial = initial;
        this.delta = target - initial;
        this.duration = duration;
        this.ease = nullEase;
        this.delay = 0.0;

        this.progress = 0;
        this.value = initial;
        this.inverseDuration = 1 / (delay + duration);
    }

        function nullEase(proportion:Float):Float
            return proportion

    inline public function update(deltaTime:Float)
    {
        progress += deltaTime;
        if (progress > duration)
            progress = duration;

        var proportion = ease((progress - delay) * inverseDuration);
        value = initial + delta * proportion;
    }

    inline public function isComplete():Bool
        return progress >= duration
}
