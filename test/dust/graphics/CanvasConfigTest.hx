package dust.graphics;

import dust.camera.data.Camera;
import dust.Injector;
import nme.display.Graphics;
import nme.display.Sprite;
import dust.context.Context;

import nme.display.DisplayObjectContainer;

class CanvasConfigTest
{
    var root:DisplayObjectContainer;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        context = new Context()
            .configure(GraphicsConfig)
            .start(root);
        injector = context.injector;
    }

    @Test public function graphicsIsInjected()
    {
        Assert.isTrue(injector.hasMapping(Graphics));
    }

    @Test public function cameraIsInjected()
    {
        Assert.isTrue(injector.hasMapping(Camera));
    }
}
