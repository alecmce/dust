package dust.canvas.data;

import dust.entities.api.Entity;
import dust.camera.data.Camera;
import dust.canvas.data.Painter;
import dust.components.Component;

import nme.display.Graphics;

class PrioritizedPainter extends Component
{
    public var painter:Painter;
    public var priority:Int;

    public function new(painter:Painter, priority:Int)
    {
        this.painter = painter;
        this.priority = priority;
    }

    inline public function draw(entity:Entity, graphics:Graphics)
        painter.draw(entity, graphics)
}
