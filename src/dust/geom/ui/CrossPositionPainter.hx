package dust.geom.ui;

import dust.camera.data.Camera;
import dust.entities.api.Entity;
import dust.graphics.data.Painter;
import dust.geom.data.Position;
import dust.graphics.data.Paint;

import nme.display.Graphics;

class CrossPositionPainter extends Painter
{
    var paint:Paint;
    var screen:Position;

    public function new(paint:Paint)
    {
        this.paint = paint;
        screen = new Position();
    }

    override public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawCross)

        function drawCross(entity:Entity, graphics:Graphics)
        {
            var camera:Camera = entity.get(Camera);
            var position:Position = entity.get(Position);

            camera.toScreen(position, screen);
            graphics.moveTo(screen.x - 5, screen.y - 5);
            graphics.lineTo(screen.x + 5, screen.y + 5);
            graphics.moveTo(screen.x - 5, screen.y + 5);
            graphics.lineTo(screen.x + 5, screen.y - 5);
        }
}
