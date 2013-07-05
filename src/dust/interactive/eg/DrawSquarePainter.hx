package dust.interactive.eg;

import dust.graphics.data.Painter;
import dust.entities.Entity;
import dust.camera.data.Camera;
import dust.graphics.data.Paint;
import dust.graphics.data.Painters;
import dust.geom.data.Position;
import flash.display.Graphics;

class DrawSquarePainter implements Painter
{
    public var paint:Paint;
    var position:Position;
    var screen:Position;

    public function new(paint:Paint, position:Position)
    {
        this.paint = paint;
        this.position = position;
        screen = new Position();
    }

    public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawSquare);

        function drawSquare(entity:Entity, graphics:Graphics)
        {
            var camera:Camera = entity.get(Camera);
            camera.toScreen(position, screen);
            graphics.drawRect(screen.x - 10, screen.y - 10, 20, 20);
        }
}
