package dust.quadtree.systems;

import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.quadtree.data.QuadTree;
import dust.systems.System;

class UpdateQuadTreesSystem implements System
{
    @inject public var collection:Collection;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            updateQuadTree(entity);
    }

        function updateQuadTree(entity:Entity)
        {
            var tree:QuadTree<Dynamic> = entity.get(QuadTree);
            tree.update();
        }
}
