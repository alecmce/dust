package dust.interactive.config;

import dust.interactive.data.Draggable;
import dust.geom.Position;
import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.entities.api.Entity;

class OffsetDecorator
{
    @inject
    public var draggableDecorator:DraggableDecorator;

    public function apply(master:Entity, entity:Entity)
    {
        ensureEntityIsDraggable(master);
        ensureEntityIsDraggable(entity);
        addOffsetsToEntity(master, entity);
    }

        function ensureEntityIsDraggable(entity:Entity)
        {
            if (!entity.has(Draggable))
                draggableDecorator.apply(entity);
        }

        function addOffsetsToEntity(master:Entity, linked:Entity)
        {
            var method = master.has(Offsets) ? addToExistingOffsets : applyNewOffets;
            method(master, linked.get(Position));
        }

            function addToExistingOffsets(master:Entity, position:Position)
            {
                master.get(Offsets).offsets.push(position);
            }

            function applyNewOffets(master:Entity, position:Position)
            {
                var masterPosition = master.get(Position);
                var offsets = new Offsets(masterPosition, [position]);
                master.add(offsets);
            }

    public function clear(entity:Entity)
    {
        entity.remove(Offsets);
        draggableDecorator.clear(entity);
        draggableDecorator.clear(entity);
    }
}
