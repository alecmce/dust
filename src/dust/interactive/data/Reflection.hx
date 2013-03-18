package dust.interactive.data;

import dust.components.Component;
import dust.geom.Position;

class Reflection extends Component
{
    public var center:Position;
    public var target:Position;
    public var scale:Float;

    public function new(center:Position, target:Position, scale:Float = 1)
    {
        this.center = center;
        this.target = target;
        this.scale = scale;
    }
}