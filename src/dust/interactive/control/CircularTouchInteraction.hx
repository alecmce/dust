package dust.interactive.control;
import flash.display.Graphics;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.TouchInteractive.TouchInteractiveResponse;
import dust.entities.Entity;
import dust.geom.data.Position;
import dust.camera.data.Camera;

class CircularTouchInteraction implements TouchInteractive
{
    var camera:Camera;
    var screen:Position;
    var radius:Float;
    var value:Float;

    public function new(camera:Camera, radius:Float)
    {
        this.camera = camera;
        this.radius = radius;
        this.value = radius * radius;
        this.screen = new Position();
    }

    public function isAtPosition(entity:Entity, mouse:Position):TouchInteractiveResponse
    {
        camera.toScreen(entity.get(Position), screen);

        var dx = mouse.x - screen.x;
        var dy = mouse.y - screen.y;
        var dd = dx * dx + dy * dy;
        var v = value * camera.scalar;

        return {isAtPosition:dd < v, distance:dd};
    }

    public function draw(entity:Entity, graphics:Graphics)
    {
        camera.toScreen(entity.get(Position), screen);
        var r = radius * camera.scalar;

        graphics.lineStyle(3, 0x00FF00);
        graphics.drawCircle(screen.x, screen.y, radius);
    }
}

