package dust.interactive.control;

import dust.app.data.App;
import dust.camera.data.Camera;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.entities.api.Entity;
import dust.interactive.data.TouchInteractive;

class TouchInteractiveFactory
{
    @inject public var camera:Camera;

    var scalar:Float;

    @inject public function new(app:App)
    {
        scalar = app.isMultiTouch ? 2.5 : 1;
    }

    public function makeCircular(radius:Float):TouchInteractive
    {
        var circular = new CircularTouchAlgorithm(camera, radius * scalar);
        return new TouchInteractive(circular.isWithinRadius);
    }

    public function makeSquare(distance:Float):TouchInteractive
    {
        var square = new SquareTouchAlgorithm(camera, distance * scalar);
        return new TouchInteractive(square.isWithinSquare);
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
        return {isAtPosition:dd < value, distance:dd};
    }
}

class SquareTouchAlgorithm
{
    var camera:Camera;
    var value:Float;
    var screen:Position;

    public function new(camera:Camera, halfLength:Float)
    {
        this.camera = camera;
        this.value = halfLength;
        this.screen = new Position();
    }

    public function isWithinSquare(entity:Entity, mouse:Position):TouchInteractiveResponse
    {
        var world:Position = entity.get(Position);
        camera.toScreen(world, screen);

        var dx = mouse.x - screen.x;
        var dy = mouse.y - screen.y;
        var dd = dx * dx + dy * dy;
        var isAtPosition = dx >= -value && dx <= value && dy >= -value && dy <= value;
        return {isAtPosition:isAtPosition , distance:dd};
    }
}
