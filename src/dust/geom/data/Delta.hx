package dust.geom.data;

import dust.components.Component;

class Delta extends Component
{
    public var dx:Float;
    public var dy:Float;

    public function new(dx:Float, dy:Float)
    {
        this.dx = dx;
        this.dy = dy;
    }
}
