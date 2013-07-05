package dust.physics.eg;

import dust.math.trig.Trig;
import dust.physics.data.Box;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import flash.display.Graphics;
import dust.entities.Entity;
import dust.graphics.data.Paint;
import dust.graphics.data.Painter;

class BoxPainter implements Painter
{
    inline static var QUARTER_PI = 3.14159265359 / 4;

    public var paint:Paint;
    public var trig:Trig;

    var screen:Position;

    public function new(paint:Paint, trig:Trig)
    {
        this.paint = paint;
        this.trig = trig;

        screen = new Position();
    }

    public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawQuad);

        function drawQuad(entity:Entity, graphics:Graphics)
        {
            var position:Position = entity.get(Position);
            var camera:Camera = entity.get(Camera);
            var box:Box = entity.get(Box);

            camera.toScreen(position, screen);
            trig.setAngle(position.rotation + QUARTER_PI);

            var size = box.size * camera.scalar;
            var dx = size * trig.getCosine();
            var dy = size * trig.getSine();

            graphics.moveTo(screen.x + dx, screen.y + dy);
            graphics.lineTo(screen.x - dy, screen.y + dx);
            graphics.lineTo(screen.x - dx, screen.y - dy);
            graphics.lineTo(screen.x + dy, screen.y - dx);
            graphics.lineTo(screen.x + dx, screen.y + dy);
        }
}
