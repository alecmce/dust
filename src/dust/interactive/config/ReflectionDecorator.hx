package dust.interactive.config;

import dust.interactive.data.Draggable;
import dust.entities.api.Entity;
import dust.interactive.data.Reflection;
import dust.geom.data.Position;

class ReflectionDecorator
{
    @inject
    public var draggableDecorator:DraggableDecorator;

    public function apply(entity:Entity, center:Entity, reflected:Entity, scale:Float = 1)
    {
        ensureEntityIsDraggable(entity);
        ensureEntityIsDraggable(center);
        addReflectionToEntity(entity, center, reflected, scale);
    }

        function ensureEntityIsDraggable(entity:Entity)
        {
            if (!entity.has(Draggable))
                draggableDecorator.apply(entity);
        }

        function addReflectionToEntity(entity:Entity, center:Entity, reflected:Entity, scale:Float = 1)
        {
            var centerPosition = center.get(Position);
            var rightPosition = reflected.get(Position);
            var reflection = new Reflection(centerPosition, rightPosition, scale);
            entity.add(reflection);
        }

    public function clear(entity:Entity)
    {
        entity.remove(Reflection);
        draggableDecorator.clear(entity);
        draggableDecorator.clear(entity);
    }
}
