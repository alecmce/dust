package dust.interactive.eg;

import dust.entities.api.Entity;
import dust.camera.data.Camera;
import dust.canvas.data.Paint;
import dust.canvas.data.Painter;
import dust.geom.data.Position;
import nme.display.Graphics;

class DrawSquarePainter extends Painter
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

    override public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawSquare)

    function drawSquare(entity:Entity, graphics:Graphics)
    {
        var camera:Camera = entity.get(Camera);
        camera.toScreen(position, screen);
        graphics.drawRect(screen.x - 10, screen.y - 10, 20, 20);
    }
}
