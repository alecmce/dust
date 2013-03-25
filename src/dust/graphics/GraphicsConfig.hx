package dust.graphics;

import dust.camera.CameraConfig;
import dust.context.DependentConfig;
import dust.camera.data.Camera;
import dust.context.Context;
import dust.context.Config;

import minject.Injector;
import nme.display.Graphics;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;

class GraphicsConfig implements DependentConfig
{
    @inject public var context:Context;
    @inject public var injector:Injector;
    @inject public var root:DisplayObjectContainer;

    var canvas:Sprite;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig]

    public function configure()
    {
        canvas = new Sprite();
        root.addChild(canvas);
        injector.mapValue(Graphics, canvas.graphics);
        context.stopped.bind(onStopped);
    }

        function onStopped()
        {
            canvas.graphics.clear();
            root.removeChild(canvas);
        }
}
