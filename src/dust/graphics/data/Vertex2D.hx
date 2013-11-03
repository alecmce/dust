package dust.graphics.data;

class Vertex2D
{
    public var x:Float;
    public var y:Float;

    public function new(x:Float = 0.0, y:Float = 0.0)
    {
        this.x = x;
        this.y = y;
    }

    public function scale(scalar:Float)
    {
        x *= scalar;
        y *= scalar;
    }

    public function offset(dx:Float = 0.0, dy:Float = 0.0)
    {
        x += dx;
        y += dy;
    }

    public function clone():Vertex2D
    {
        return new Vertex2D(x, y);
    }

    public function toString():String
    {
        return '[Vertex2D x:$x, y:$y]';
    }
}

