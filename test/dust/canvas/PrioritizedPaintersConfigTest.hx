package dust.canvas;

import minject.Injector;
import dust.canvas.control.PrioritizedPaintersSystem;
import dust.context.Context;
import dust.systems.impl.Systems;

import massive.munit.Assert;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;

class PrioritizedPaintersConfigTest
{
    var root:DisplayObjectContainer;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        injector = new Injector();
        context = new Context(injector)
            .configure(PrioritizedPaintersConfig)
            .start(root);
    }

    @Test public function graphicsIsInjected()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isTrue(systems.hasMapping(PrioritizedPaintersSystem));
    }
}
