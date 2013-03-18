package dust.interactive.data;

import dust.geom.Position;
import dust.components.Component;

class ClickFocus extends Component
{
    public var position:Position;
    public var isClick:Bool;
    public var isDown:Bool;

    public function new()
    {
        position = new Position();
        isClick = false;
        isDown = false;
    }
}
