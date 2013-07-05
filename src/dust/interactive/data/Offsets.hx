package dust.interactive.data;

import dust.geom.data.Position;

class Offsets
{
    public var current:Position;
    public var offsets:Array<Position>;

    public function new(current:Position, offsets:Array<Position>)
    {
        this.current = new Position(current.x, current.y);
        this.offsets = offsets;
    }
}