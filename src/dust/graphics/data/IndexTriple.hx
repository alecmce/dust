package dust.graphics.data;

class IndexTriple
{
    public var a:Int;
    public var b:Int;
    public var c:Int;

    public function new(a:Int, b:Int, c:Int)
    {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public function toString():String
    {
        return '[IndexTriple $a, $b, $c]';
    }
}
