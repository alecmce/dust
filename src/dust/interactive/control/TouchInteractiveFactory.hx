package dust.interactive.control;

import dust.camera.data.Camera;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.entities.Entity;
import dust.interactive.data.TouchInteractive;

class TouchInteractiveFactory
{
    @inject public var camera:Camera;

    public function makeCircular(radius:Float):TouchInteractive
    {
        var algorithm = new CircularTouchAlgorithm(camera, radius);
        return new TouchInteractive(algorithm.isWithinRadius);
    }

    public function makeSquare(distance:Float):TouchInteractive
    {
        return makeRectangular(distance, distance);
    }

    public function makeRectangular(horizontal:Float, vertical:Float):TouchInteractive
    {
        var algorithm = new RectangularTouchAlgorithm(camera, horizontal, vertical);
        return new TouchInteractive(algorithm.isWithinRectangle);
    }
}

class CircularTouchAlgorithm
{
    var camera:Camera;
    var screen:Position;
    var value:Float;

    public function new(camera:Camera, radius:Float)
    {
        this.camera = camera;
        this.value = radius * radius;
        this.screen = new Position();
    }

    public function isWithinRadius(entity:Entity, mouse:Position):TouchInteractiveResponse
    {
        var world:Position = entity.get(Position);
        camera.toScreen(world, screen);

        var dx = mouse.x - screen.x;
        var dy = mouse.y - screen.y;
        var dd = dx * dx + dy * dy;
        var v = value * camera.scalar;

        return {isAtPosition:dd < v, distance:dd};
    }
}

class RectangularTouchAlgorithm
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

    public function isWithinRectangle(entity:Entity, mouse:Position):TouchInteractiveResponse
    {
        var world:Position = entity.get(Position);
        camera.toScreen(world, screen);

        var dx = mouse.x - screen.x;
        var dy = mouse.y - screen.y;
        var dd = dx * dx + dy * dy;
        var h = horizontal * camera.scalar;
        var v = vertical * camera.scalar;

        var isAtPosition = dx >= -h && dx <= h && dy >= -v && dy <= v;
        return {isAtPosition:isAtPosition , distance:dd};
    }
}
