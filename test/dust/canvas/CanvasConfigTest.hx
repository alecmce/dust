package dust.canvas;

import dust.camera.data.Camera;
import minject.Injector;
import massive.munit.Assert;
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
        injector = new Injector();
        context = new Context(injector)
            .configure(CanvasConfig)
            .start(root);
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
