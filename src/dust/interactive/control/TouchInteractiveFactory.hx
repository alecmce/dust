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
        var algorithm = new CircularTouchAlgorithm(camera, radius * scalar);
        return new TouchInteractive(algorithm.isWithinRadius);
    }

    public function makeSquare(distance:Float):TouchInteractive
    {
        return makeRectangular(distance, distance);
    }

    public function makeRectangular(horizontal:Float, vertical:Float):TouchInteractive
    {
        var algorithm = new RectangularTouchAlgorithm(camera, horizontal * scalar, vertical * scalar);
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
        return {isAtPosition:dd < value, distance:dd};
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
        var isAtPosition = dx >= -horizontal && dx <= horizontal && dy >= -vertical && dy <= vertical;
        return {isAtPosition:isAtPosition , distance:dd};
    }
}
