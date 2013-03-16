package dust.interactive.data;

import dust.position.data.Position;
import dust.components.Component;
import dust.entities.api.Entity;

class MouseInteractive extends Component
{
    public var isMouseOver:Entity->Position->Bool;

    public function new(isMouseOver:Entity->Position->Bool)
        this.isMouseOver = isMouseOver
}
