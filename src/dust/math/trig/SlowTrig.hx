package dust.math.trig;

class SlowTrig implements Trig
{
    var angle:Float;

    public function new() {}

    public function setAngle(angle:Float)
        this.angle = angle

    inline public function getAngle():Float
        return angle

    inline public function getSine():Float
        return Math.sin(angle)

    inline public function getCosine():Float
        return Math.cos(angle)

    inline public function setDirection(dx:Float, dy:Float)
        angle = Math.atan2(dy, dx)
}
