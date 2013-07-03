package dust.graphics;

import dust.Injector;
import dust.graphics.systems.PainterSystem;
import dust.context.Context;
import dust.systems.impl.Systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

class PrioritizedPaintersConfigTest
{
    var root:DisplayObjectContainer;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        context = new Context()
            .configure(PaintersConfig)
            .start(root);
        injector = context.injector;
    }

    @Test public function graphicsIsInjected()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isTrue(systems.hasMapping(PainterSystem));
    }
}
