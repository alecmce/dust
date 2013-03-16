package dust.geom;

import dust.position.data.Position;

class Circle
{
    public var center:Position;
    public var radial:Position;

    var dx:Float;
    var dy:Float;

    public function new(center:Position, radial:Position)
    {
        this.center = center;
        this.radial = radial;
    }

    inline public function getAngle():Float
    {
        return Math.atan2(dy, dx);
    }

    inline public function getRadiusSquared():Float
    {
        return dx * dx + dy * dy;
    }

    inline public function getRadius():Float
    {
        return Math.sqrt(getRadiusSquared());
    }

    inline public function update()
    {
        dx = radial.x - center.x;
        dy = radial.y - center.y;
    }

    public function toString():String
    {
        return "[Circle center=" + center + ", radial=" + radial + "]";
    }
}
