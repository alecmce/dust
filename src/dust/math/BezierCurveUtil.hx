package dust.math;

class BezierCurveUtil
{
    inline public static function interpolate(p:Float, startAnchor:Float, startControl:Float, endControl:Float, endAnchor:Float):Float
    {
        var pSquared = p * p;
        var pCubed = pSquared * p;
        return startAnchor + (-startAnchor * 3 + p * (3 * startAnchor - startAnchor * p)) * p
               + (3 * startControl + p * (-6 * startControl + startControl * 3 * p)) * p
               + (endControl * 3 - endControl * 3 * p) * pSquared
               + endAnchor * pCubed;
    }

    inline public static function derivative(p:Float, startAnchor:Float, startControl:Float, endControl:Float, endAnchor:Float):Float
    {
        var pSquared = p * p;
        var oneMinusP = 1 - p;
        var oneMinusPSquared = oneMinusP * oneMinusP;
        return 3 * oneMinusPSquared * (startControl - startAnchor)
               + 6 * p * oneMinusP * (endControl - startControl)
               + 3 * pSquared * (endAnchor - endControl);
    }
}
