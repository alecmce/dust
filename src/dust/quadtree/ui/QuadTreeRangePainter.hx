package dust.quadtree.ui;

import dust.geom.Position;
import dust.camera.data.Camera;
import dust.quadtree.data.QuadTreeRange;
import dust.canvas.data.Paint;
import nme.display.Graphics;
import dust.entities.api.Entity;
import dust.canvas.data.Painter;

class QuadTreeRangePainter extends Painter
{
    var paint:Paint;
    var screen:Position;

    public function new(paint:Paint)
    {
        this.paint = paint;
        this.screen = new Position();
    }

    override public function draw(entity:Entity, graphics:Graphics)
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
