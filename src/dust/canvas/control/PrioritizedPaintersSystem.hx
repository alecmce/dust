package dust.canvas.control;

import dust.camera.data.Camera;
import dust.canvas.data.Painter;
import dust.canvas.data.PrioritizedPainter;
import dust.entities.api.Collection;
import dust.lists.Pool;
import dust.lists.SortedList;
import dust.systems.System;

import nme.display.Graphics;

class PrioritizedPaintersSystem implements System
{
    inline static var MAX = 0x3FFFFFFF;

    @inject public var graphics:Graphics;
    @inject public var entities:Collection;
    @inject public var camera:Camera;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        graphics.clear();
        for (entity in entities)
        {
            var painter:PrioritizedPainter = entity.get(PrioritizedPainter);
            painter.draw(entity, graphics);
        }
    }
}
