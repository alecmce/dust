package dust.interactive.data;

import dust.position.data.Position;
import dust.components.Component;

class Offsets extends Component
{
    public var current:Position;
    public var offsets:Array<Position>;

    public function new(current:Position, offsets:Array<Position>)
    {
        this.current = new Position(current.x, current.y);
        this.offsets = offsets;
    }
}