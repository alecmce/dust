package dust.math.trig;

class LowPrecisionFastTrig implements Trig
{
    var angle:Float;

    public function new() {}

    public function setAngle(angle:Float)
    {
        this.angle = if (angle < -3.14159265)
            angle + 6.28318531;
        else if (angle >  3.14159265)
            angle - 6.28318531;
        else
            angle;
    }

    inline public function getAngle():Float
        return angle;

    inline public function getSine():Float
        return approximateSine(angle);

    inline public function getCosine():Float
    {
        var n = angle + 1.57079632;
        if (n >  3.14159265)
            n -= 6.28318531;

        return approximateSine(n);
    }

        inline function approximateSine(angle:Float):Float
        {
            var square = angle * angle;
            return if (angle < 0)
                1.27323954 * angle + 0.405284735 * square;
            else
                1.27323954 * angle - 0.405284735 * square;
        }

    inline public function setDirection(dx:Float, dy:Float):Void
        angle = Math.atan2(dy, dx);

}