package dust.camera.control;

import dust.app.data.App;
import dust.camera.data.Camera;

class CameraFactory
{
    @inject public var app:App;

    public function new() {}

    public function make():Camera
    {
        var screenCenterX = Std.int(app.stageWidth * 0.5);
        var screenCenterY = Std.int(app.stageHeight * 0.5);

        return if (app.isRetina())
            new Camera(screenCenterX, screenCenterY, 1);
        else
            new Camera(screenCenterX, screenCenterY, 0.5);
    }
}
