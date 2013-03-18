package dust.quadtree.data;

import dust.geom.Position;

class QuadTreeData<T>
{
    public var data:T;
    public var position:Position;

    public function new(position:Position, data:T)
    {
        this.position = position;
        this.data = data;
    }

    public function toString():String
        return "[QuadTreeData position=" + position + ", data=" + data + "]"
}
