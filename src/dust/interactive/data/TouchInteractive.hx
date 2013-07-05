package dust.interactive.data;

import dust.geom.data.Position;
import dust.entities.Entity;

typedef TouchInteractiveResponse = {isAtPosition:Bool, distance:Float};

class TouchInteractive
{
    public var isAtPosition:Entity->Position->TouchInteractiveResponse;

    public function new(isAtPosition:Entity->Position->TouchInteractiveResponse)
        this.isAtPosition = isAtPosition;
}