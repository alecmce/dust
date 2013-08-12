package dust.geom.data;

class Position
{
    public static function areEqual(a:Position, b:Position):Bool
    {
        return a.x == b.x && a.y == b.y;
    }

    public static function areClose(a:Position, b:Position, threshold:Float):Bool
    {
        var dx = b.x - a.x;
        var dy = b.y - a.y;
        var dz = b.z - a.z;

        return ((dx >= 0 && dx < threshold) || (dx < 0 && dx > -threshold)) &&
               ((dy >= 0 && dy < threshold) || (dy < 0 && dy > -threshold)) &&
               ((dz >= 0 && dz < threshold) || (dz < 0 && dz > -threshold));
    }

    public static function squareDistance(a:Position, b:Position):Float
    {
        var dx = b.x - a.x;
        var dy = b.y - a.y;
        var dz = b.z - a.z;

        return dx * dx + dy * dy + dz * dz;
    }

    public var x:Float;
    public var y:Float;
    public var z:Float;
    public var rotation:Float;

    public function new(x:Float = 0.0, y:Float = 0.0, z:Float = 0.0, rotation:Float = 0.0)
    {
        this.x = x;
        this.y = y;
        this.z = z;
        this.rotation = rotation;
    }

    public function set(x:Float, y:Float, z:Float)
    {
        #if debug
        if (x != x || y != y || z != z)
            throw "Position set to null!";
        #end

        this.x = x;
        this.y = y;
        this.z = z;
    }

    public function offset(dx:Float, dy:Float, dz:Float):Position
    {
        x += dx;
        y += dy;
        z += dz;
        return this;
    }

    public function offsetDelta(delta:Delta):Position
    {
        x += delta.dx;
        y += delta.dy;
        z += delta.dz;
        return this;
    }

    public function clone():Position
    {
        return new Position(x, y, z);
    }

    public function setTo(position:Position):Position
    {
        this.x = position.x;
        this.y = position.y;
        this.z = position.z;
        this.rotation = position.rotation;
        return this;
    }

    public function setToPosition(position:Position)
    {
        this.x = position.x;
        this.y = position.y;
        this.z = position.z;
    }

    public function rotate2DAbout(angle:Float, center:Position)
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
    {
        return '[Position x: $x, y: $y, z: $z, rotation: $rotation]';
    }
}
