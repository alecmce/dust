package dust.interactive.control;

import dust.interactive.data.TouchInteractive;
import dust.geom.data.Position;
import dust.camera.data.Camera;
import dust.entities.Entity;
import dust.multitouch.control.Touches;
import dust.collections.api.Collection;

class TouchSelector
{
    inline static var BIG_VALUE = 65535;

    @inject public var touches:Touches;
    @inject public var camera:Camera;

    public function new() {}

    public function select(collection:Collection):Entity
    {
        var touch = touches.getByIndex(touches.getCount() - 1).current;
        var current = null;
        var distance = BIG_VALUE;

        for (entity in collection)
        {
            var result = isAtPosition(entity, touch);
            if (result.isAtPosition && result.distance < distance)
            {
                distance = result.distance;
                current = entity;
            }
        }

        return current;
    }

            inline function isAtPosition(entity:Entity, touch:Position):TouchInteractiveResponse
            {
                var interactive:TouchInteractive = entity.get(TouchInteractive);
                return interactive.isAtPosition(entity, touch);
            }
}
