package dust.interactive.control;
import flash.display.Graphics;
import dust.entities.Entity;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.TouchInteractive.TouchInteractiveResponse;
import dust.geom.data.Position;
import dust.camera.data.Camera;

class RectangularTouchInteraction implements TouchInteractive
{
    var camera:Camera;
    var horizontal:Float;
    var vertical:Float;
    var screen:Position;

    public function new(camera:Camera, horizontal:Float, vertical:Float)
    {
        this.camera = camera;
        this.horizontal = horizontal;
        this.vertical = horizontal;
        this.screen = new Position();
    }

    public function isAtPosition(entity:Entity, mouse:Position):TouchInteractiveResponse
    {
        camera.toScreen(entity.get(Position), screen);

        var dx = mouse.x - screen.x;
        var dy = mouse.y - screen.y;
        var dd = dx * dx + dy * dy;
        var h = horizontal * 0.5 * camera.scalar;
        var v = vertical * 0.5 * camera.scalar;

        var isAtPosition = dx >= -h && dx <= h && dy >= -v && dy <= v;
        return {isAtPosition:isAtPosition , distance:dd};
    }

    public function draw(entity:Entity, graphics:Graphics)
    {
        camera.toScreen(entity.get(Position), screen);
        var h = horizontal * camera.scalar;
        var v = vertical * camera.scalar;

        graphics.lineStyle(3, 0x00FF00);
        graphics.drawRect(screen.x - h * 0.5, screen.y - v * 0.5, h, v);
    }
}
