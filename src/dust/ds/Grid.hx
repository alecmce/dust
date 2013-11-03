package dust.ds;

class Grid<T>
{
    public var columns:Int;
    public var rows:Int;
    var data:Array<T>;

    public function new(columns:Int, rows:Int)
    {
        this.columns = columns;
        this.rows = rows;
        this.data = new Array<T>();
    }

    public function get(x:Int, y:Int):T
    {
        checkBounds(x, y);
        return data[getIndex(x, y)];
    }

    public function set(x:Int, y:Int, datum:T)
    {
        checkBounds(x, y);
        data[getIndex(x, y)] = datum;
    }

    inline function checkBounds(x:Int, y:Int)
        if (x < 0 || y < 0 || x >= columns || y >= rows)
            throw new OutOfGridBoundsError();

    inline function getIndex(x:Int, y:Int):Int
        return y * columns + x;

    public function iterator():Iterator<T>
        return data.iterator();
}

class OutOfGridBoundsError
{
    public function new() {}
}