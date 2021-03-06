package dust.math;

import dust.geom.data.Delta;
import dust.geom.data.Position;

class AnglesUtil
{
    inline static public var PI = 3.141592653589793;
    inline static public var TWO_PI = 2 * PI;
    inline static public var HALF_PI = PI / 2;
    inline static public var QUARTER_PI = PI / 4;
    inline static public var TO_RADIANS = PI / 180;
    inline static public var TO_DEGREES = 180 / PI;

    inline public static function constrainToHalfTurn(angle:Float):Float
    {
        if (angle < -PI)
        {
            while (angle < -PI)
                angle += TWO_PI;
        }
        else if (angle > PI)
        {
            while (angle > PI)
                angle -= TWO_PI;
        }

        return angle;
    }

    inline public static function directedAngle(a:Float, b:Float):Float
        return constrainToHalfTurn(constrainToHalfTurn(b) - constrainToHalfTurn(a));

    inline public static function directedAngleFromVectors(aI:Float, aJ:Float, bI:Float, bJ:Float):Float
    {
        var angA = -Math.atan2(aJ, aI);
        var cosA = Math.cos(angA);
        var sinA = Math.sin(angA);

        var i = bI * cosA - bJ * sinA;
        var j = bI * sinA + bJ * cosA;

        return Math.atan2(j, i);
    }

    inline public static function directedAngleFromDeltas(a:Delta, b:Delta):Float
        return directedAngleFromVectors(a.dx, a.dy, b.dx, b.dy);

    inline public static function directedAngleFromVertices(center:Position, a:Position, b:Position):Float
    {
        var aI = a.x - center.x;
        var aJ = a.y - center.y;
        var bI = b.x - center.x;
        var bJ = b.y - center.y;
    
        return directedAngleFromVectors(aI, aJ, bI, bJ);
    }
    
    inline public static function toDegrees(radians:Float):Float
        return radians * TO_DEGREES;

    inline public static function toRadians(degrees:Float):Float
        return degrees * TO_RADIANS;
}
