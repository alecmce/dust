package dust.quadtree.control;

import dust.console.ui.ConsoleOutput;
import dust.geom.data.Position;

// TODO calculate via dust.math.geom.LineIntersection
class LineSegmentIntersection
{
    var ax:Float;
    var ay:Float;
    var adx:Float;
    var ady:Float;

    var bx:Float;
    var by:Float;
    var bdx:Float;
    var bdy:Float;

    var divisor:Float;
    public var aProportion:Float;
    public var bProportion:Float;

    public function new() {}

    inline public function setLineA(x:Float, y:Float, dx:Float, dy:Float):LineSegmentIntersection
    {
        ax = x;
        ay = y;
        adx = dx;
        ady = dy;
        return this;
    }

    inline public function setLineB(x:Float, y:Float, dx:Float, dy:Float):LineSegmentIntersection
    {
        bx = x;
        by = y;
        bdx = dx;
        bdy = dy;
        return this;
    }

    public function calculate():LineSegmentIntersection
    {
        divisor = adx * bdy - bdx * ady;
        if (divisor != 0)
        {
            aProportion = proportionAlongA();
            bProportion = proportionAlongB();
        }
        return this;
    }

        inline function proportionAlongA():Float
            return (bdx * (ay - by) - bdy * (ax - bx)) / divisor

        inline function proportionAlongB():Float
            return (bdx != 0) ? (ax - bx + adx * aProportion) / bdx : (ay - by + ady * aProportion) / bdy


    public function isIntersection():Bool
        return areNotParallelLines() && intersectionLiesOnSegments()

        inline function areNotParallelLines():Bool
            return divisor != 0 && divisor == divisor

        inline function intersectionLiesOnSegments():Bool
            return isInBounds(aProportion) && isInBounds(bProportion)

            inline function isInBounds(proportion:Float):Bool
                return proportion >= 0 && proportion < 1

    public function setToIntersection(position:Position)
    {
        position.x = ax + aProportion * adx;
        position.y = ay + aProportion * ady;
    }
}
