package dust.interactive.systems;

import dust.interactive.data.Offsets;
import dust.interactive.data.Reflection;
import dust.geom.data.Position;
import dust.collections.api.Collection;
import dust.entities.Entity;
import dust.interactive.data.Draggable;
import dust.systems.System;

class OffsetSystem implements System
{
    @inject public var collection:Collection;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            updateOffsetPositions(entity);
    }

        inline function updateOffsetPositions(entity:Entity)
        {
            var position:Position = entity.get(Position);
            var offsets:Offsets = entity.get(Offsets);

            var current = offsets.current;
            var dx = position.x - current.x;
            var dy = position.y - current.y;
            current.setTo(position);

            for (offset in offsets.offsets)
                offset.offset(dx, dy, 0);
        }
}