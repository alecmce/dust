package dust.interactive.data;

import dust.geom.data.Position;
import dust.components.Component;
import dust.entities.api.Entity;

typedef TouchInteractiveResponse = {isAtPosition:Bool, distance:Float};

class TouchInteractive extends Component
{
    public var isAtPosition:Entity->Position->TouchInteractiveResponse;

    public function new(isAtPosition:Entity->Position->TouchInteractiveResponse)
        this.isAtPosition = isAtPosition
}