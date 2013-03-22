package dust.interactive.systems;

import dust.interactive.data.Reflection;
import dust.geom.data.Position;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.interactive.data.Draggable;
import dust.systems.System;

import nme.display.InteractiveObject;
import nme.display.Stage;

class ReflectionSystem implements System
{
    var collection:Collection;

    var target:InteractiveObject;
    var dragging:Entity;
    var stage:Stage;

    @inject
    public function new(collection:Collection)
    {
        this.collection = collection;
    }

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
        {
            var position:Position = entity.get(Position);
            var reflection:Reflection = entity.get(Reflection);

            var center = reflection.center;
            var target = reflection.target;
            var scale = reflection.scale;

            var x = center.x + (center.x - position.x) * scale;
            var y = center.y + (center.y - position.y) * scale;
            target.set(x, y);
        }
    }
}
