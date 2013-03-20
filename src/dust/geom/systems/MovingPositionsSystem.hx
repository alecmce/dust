package dust.geom.systems;

import dust.geom.data.Delta;
import dust.geom.data.Position;
import dust.entities.api.Entity;
import dust.quadtree.eg.QuadTreeVisualizationExample;
import dust.collections.api.Collection;
import dust.systems.System;

class MovingPositionsSystem implements System
{
    inline static var EXTENT = QuadTreeVisualizationExample.EXTENT;

    @inject public var collection:Collection;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            update(entity);
    }

    function update(entity:Entity)
    {
        var position:Position = entity.get(Position);
        var delta:Delta = entity.get(Delta);

        position.offset(delta.dx, delta.dy);

        if (position.x > EXTENT)
            position.x -= 2 * EXTENT;
        else if (position.x < -EXTENT)
            position.x += 2 * EXTENT;

        if (position.y > EXTENT)
            position.y -= 2 * EXTENT;
        else if (position.y < -EXTENT)
            position.y += 2 * EXTENT;
    }
}