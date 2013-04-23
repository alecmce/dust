package dust.geom.data;

import dust.components.Component;

class Position extends Component
{
    public static function areEqual(a:Position, b:Position):Bool
        return a.x == b.x && a.y == b.y

    public static function areClose(a:Position, b:Position, threshold:Float):Bool
    {
        var dx = b.x - a.x;
        var dy = b.y - a.y;
        return ((dx > 0 && dx < threshold) || (dx < 0 && dx > -threshold)) &&
               ((dy > 0 && dy < threshold) || (dy < 0 && dy > -threshold));
    }

    public static function squareDistance(a:Position, b:Position):Float
    {
        var dx = b.x - a.x;
        var dy = b.y - a.y;
        return dx * dx + dy * dy;
    }

    public var x:Float;
    public var y:Float;
    public var rotation:Float;

    public function new(x:Float = 0.0, y:Float = 0.0, rotation:Float = 0.0)
    {
        this.x = x;
        this.y = y;
        this.rotation = rotation;
    }

    public function set(x:Float, y:Float)
    {
        this.x = x;
        this.y = y;
    }

    public function offset(dx:Float, dy:Float)
    {
        x += dx;
        y += dy;
    }

    public function clone():Position
        return new Position(x, y)

    public function setTo(position:Position)
    {
        this.x = position.x;
        this.y = position.y;
        this.rotation = position.rotation;
    }

    public function setToPositionXY(position:Position)
    {
        this.x = position.x;
        this.y = position.y;
    }

    public function rotateAbout(angle:Float, center:Position)
    {
        x -= center.x;
        y -= center.y;

        var cos = Math.cos(angle);
        var sin = Math.sin(angle);
        var ny = sin * x + cos * y;
        x = cos * x - sin * y;
        y = ny;

        x += center.x;
        y += center.y;
    }

    public function toString():String
        return "[Position x=" + x + ", y=" + y + ", angle=" + rotation + "]"
}
