package dust.keys;

import dust.keys.impl.Keys;
import dust.keys.impl.KeyControllerSystem;
import dust.context.Context;
import dust.systems.impl.Systems;
import massive.munit.Assert;
import dust.keys.impl.KeyControls;
import nme.display.Sprite;
import minject.Injector;
import nme.display.DisplayObjectContainer;

class KeysConfigTest
{
    var root:DisplayObjectContainer;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        injector = new Injector();
        context = new Context(injector)
            .configure(KeysConfig)
            .start(root);
    }

    @After
    public function after()
    {
        context.stop();
    }

    @Test public function keysAreMapped()
    {
        Assert.isTrue(injector.hasMapping(Keys));
    }

    @Test public function keyControlsAreMapped()
    {
        Assert.isTrue(injector.hasMapping(KeyControls));
    }

    @Test public function canAddKeyControlToControls()
    {
        var keyControls:KeyControls = injector.getInstance(KeyControls);
        keyControls.map(1, nullMethod);
    }

        function nullMethod(deltaTime:Float) {}

    @Test public function keyControllerSystemIsConfigured()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isTrue(systems.hasMapping(KeyControllerSystem));
    }
}
