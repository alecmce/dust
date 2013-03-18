package dust.interactive.config;

import dust.interactive.data.MouseInteractive;
import dust.geom.Position;
import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.entities.api.Entity;

class MouseInteractiveDecorator
{
    public function apply(entity:Entity)
    {
        var interactive = new MouseInteractive(isMouseOver);
        entity.add(interactive);
    }

        function isMouseOver(entity:Entity, mouse:Position):Bool
        {
            var position:Position = entity.get(Position);
            var dx = mouse.x - position.x;
            var dy = mouse.y - position.y;
            return dx >= -10 && dx <= 10 && dy >= -10 && dy <= 10;
        }

    public function clear(entity:Entity)
    {
        entity.remove(MouseInteractive);
    }
}