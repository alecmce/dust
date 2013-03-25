package dust.graphics;

import minject.Injector;
import dust.graphics.control.PainterSystem;
import dust.context.Context;
import dust.systems.impl.Systems;

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
            .configure(PaintersConfig)
            .start(root);
    }

    @Test public function graphicsIsInjected()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isTrue(systems.hasMapping(PainterSystem));
    }
}
