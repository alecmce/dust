package dust.math.geom;

import dust.geom.data.Position;

class LineIntersection
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

    inline public function setLineA(x:Float, y:Float, dx:Float, dy:Float):LineIntersection
    {
        ax = x;
        ay = y;
        adx = dx;
        ady = dy;
        return this;
    }

    inline public function setLineB(x:Float, y:Float, dx:Float, dy:Float):LineIntersection
    {
        bx = x;
        by = y;
        bdx = dx;
        bdy = dy;
        return this;
    }

    inline public function setToIntersection(position:Position)
    {
        divisor = adx * bdy - bdx * ady;
        aProportion = proportionAlongA();
        bProportion = proportionAlongB();

        position.x = ax + aProportion * adx;
        position.y = ay + aProportion * ady;
    }

        inline function proportionAlongA():Float
            return (bdx * (ay - by) - bdy * (ax - bx)) / divisor;

        inline function proportionAlongB():Float
            return (bdx != 0) ? (ax - bx + adx * aProportion) / bdx : (ay - by + ady * aProportion) / bdy;
}
