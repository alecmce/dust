package dust.interactive.control;

import dust.interactive.data.TouchInteractive;
import dust.interactive.data.Draggable;
import dust.geom.data.Position;
import dust.interactive.data.Offsets;
import dust.entities.Entity;
import dust.entities.Entity;

class DraggableDecorator
{
    @inject public var factory:TouchInteractiveFactory;

    var halfLength:Float;

    public function new()
        halfLength = 10.0;

    public function setHalfLength(halfLength:Float):DraggableDecorator
    {
        this.halfLength = halfLength;
        return this;
    }

    public function apply(entity:Entity):Entity
    {
        if (!entity.has(TouchInteractive))
            entity.add(factory.makeSquare(halfLength));
        entity.add(new Draggable());
        return entity;
    }

    public function clear(entity:Entity)
    {
        entity.remove(Draggable);
        entity.remove(TouchInteractive);
    }
}