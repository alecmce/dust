package dust.quadtree.data;

import dust.geom.Position;

class OutOfBoundsError
{
    public var position:Position;
    public var range:QuadTreeRange;

    public function new(position:Position, range:QuadTreeRange)
    {
        this.position = position;
        this.range = range;
    }

    public function toString():String
        return "[OutOfBoundsError position=" + position + ", range=" + range + "]"
}
