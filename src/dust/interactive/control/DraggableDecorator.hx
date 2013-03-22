package dust.interactive.control;

import dust.interactive.data.MouseInteractive;
import dust.interactive.data.Draggable;
import dust.geom.data.Position;
import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.entities.api.Entity;

class DraggableDecorator
{
    @inject
    public var interactiveDecorator:MouseInteractiveDecorator;

    public function apply(entity:Entity):Entity
    {
        if (!entity.has(MouseInteractive))
            interactiveDecorator.apply(entity);
        entity.add(new Draggable());
        return entity;
    }

    public function clear(entity:Entity)
    {
        entity.remove(Draggable);
        interactiveDecorator.clear(entity);
    }
}