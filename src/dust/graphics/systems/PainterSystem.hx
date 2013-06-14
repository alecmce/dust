package dust.graphics.systems;

import dust.camera.data.Camera;
import dust.graphics.data.Painters;
import dust.collections.api.Collection;
import dust.lists.Pool;
import dust.lists.SortedList;
import dust.systems.System;

import nme.display.Graphics;

class PainterSystem implements System
{
    inline static var MAX = 0x3FFFFFFF;

    @inject public var graphics:Graphics;
    @inject public var collection:Collection;
    @inject public var camera:Camera;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        graphics.clear();
        for (entity in collection)
            entity.get(Painters).draw(entity, graphics);
    }
}
