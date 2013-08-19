package dust.interactive.control;

import dust.camera.data.Camera;
import dust.interactive.data.TouchInteractive;

class TouchInteractiveFactory
{
    @inject public var camera:Camera;

    public function makeCircular(radius:Float):TouchInteractive
    {
        return new CircularTouchInteraction(camera, radius);
    }

    public function makeSquare(distance:Float):TouchInteractive
    {
        return makeRectangular(distance, distance);
    }

    public function makeRectangular(horizontal:Float, vertical:Float):TouchInteractive
    {
        return new RectangularTouchInteraction(camera, horizontal, vertical);
    }
}

