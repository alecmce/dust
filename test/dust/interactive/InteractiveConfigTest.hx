package dust.interactive;

import nme.display.Sprite;
import nme.display.DisplayObjectContainer;
import dust.context.Context;

import minject.Injector;

class InteractiveConfigTest
{
    var root:DisplayObjectContainer;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        injector = new Injector();
        context = new Context(injector)
            .configure(InteractiveConfig)
            .start(root);
    }

    @Test public function tmp()
    {

    }
}
