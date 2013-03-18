package dust.interactive.control;

import dust.interactive.data.Offsets;
import dust.interactive.data.Reflection;
import dust.position.data.Position;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.interactive.data.Draggable;
import dust.systems.System;

import nme.display.InteractiveObject;
import nme.display.Stage;

class OffsetSystem implements System
{
    @inject public var collection:Collection;

    var target:InteractiveObject;
    var dragging:Entity;
    var stage:Stage;

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
                offset.offset(dx, dy);
        }
}