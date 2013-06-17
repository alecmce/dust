package dust.quadtree.ui;

import dust.components.Component;
import dust.graphics.data.Painter;
import dust.geom.data.Position;
import dust.camera.data.Camera;
import dust.quadtree.data.QuadTreeRange;
import dust.graphics.data.Paint;
import nme.display.Graphics;
import dust.entities.api.Entity;
import dust.graphics.data.Painters;

class QuadTreeRangePainter
    extends Component,
    implements Painter
{
    public var paint:Paint;

    var screen:Position;

    public function new(paint:Paint)
    {
        this.paint = paint;
        this.screen = new Position();
    }

    public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawRange)

        function drawRange(entity:Entity, graphics:Graphics)
        {
            var range:QuadTreeRange = entity.get(QuadTreeRange);
            var camera:Camera = entity.get(Camera);

            screen.setTo(range.position);
            camera.toScreen(screen, screen);
            var size = camera.scalar * range.extent;

            graphics.drawRect(screen.x - size, screen.y - size, size * 2, size * 2);
        }
}
