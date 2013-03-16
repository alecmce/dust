package dust.lists;

class MockData
{
    public var id:Int;

    public function new(id:Int = 0)
    {
        this.id = id;
    }

    public function toString():String
    {
        return "[MockData " + id + "]";
    }
}
