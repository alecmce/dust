package dust.geom.data;

class Delta
{
    public static function fromPositions(a:Position, b:Position):Delta
    {
        return new Delta(b.x - a.x, b.y - a.y, b.rotation - a.rotation);
    }

    public static function addDeltas(a:Delta, b:Delta):Delta
    {
        return new Delta(a.dx + b.dx, a.dy + b.dy, a.dr + b.dr);
    }

    public static function subtractDeltas(a:Delta, b:Delta):Delta
    {
        return new Delta(b.dx - a.dx, b.dy - a.dy, b.dr - a.dr);
    }

    public static function dotProduct(a:Delta, b:Delta):Float
    {
        return a.dx * b.dx + a.dy * b.dy + a.dz * b.dz;
    }

    public var dx:Float;
    public var dy:Float;
    public var dz:Float;
    public var dr:Float;

    public function new(dx:Float = 0.0, dy:Float = 0.0, dz:Float = 0.0, dr:Float = 0.0)
    {
        set(dx, dy, dz, dr);
    }

    inline public function set(dx:Float = 0.0, dy:Float = 0.0, dz:Float = 0.0, dr:Float = 0.0)
    {
        this.dx = dx;
        this.dy = dy;
        this.dz = dz;
        this.dr = dr;
    }

    inline public function add(delta:Delta)
    {
        this.dx += delta.dx;
        this.dy += delta.dy;
        this.dz += delta.dz;
        this.dr += delta.dr;
    }

    inline public function subtract(delta:Delta)
    {
        this.dx -= delta.dx;
        this.dy -= delta.dy;
        this.dz -= delta.dz;
        this.dr -= delta.dr;
    }

    inline public function multiply(value:Float):Delta
    {
        dx *= value;
        dy *= value;
        dz *= value;
        dr *= value;
        return this;
    }

    inline public function limit(maxMagnitude:Float)
    {
        var magnitude = getMagnitude();
        if (magnitude > maxMagnitude)
            multiply(maxMagnitude / magnitude);
    }

    inline public function clone():Delta
    {
        return new Delta(dx, dy, dz, dr);
    }

    inline public function reset()
    {
        dx = 0.0;
        dy = 0.0;
        dz = 0.0;
    }

    inline public function getMagnitude():Float
    {
        return Math.sqrt(dx * dx + dy * dy + dz * dz);
    }

    inline public function setMagnitude(value:Float)
    {
        if (value == 0)
            reset();
        else
            multiply(value / getMagnitude());
    }

    inline public function normalize()
    {
        multiply(1 / getMagnitude());
    }

    public function toString():String
    {
        return "[Delta dx: $dx, dy: $dy, dz: $dz]";
    }
}
