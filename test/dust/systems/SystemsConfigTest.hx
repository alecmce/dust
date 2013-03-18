package dust.systems;

import dust.systems.SystemsConfig;
import dust.context.Context;
import dust.systems.impl.Systems;

import minject.Injector;
import nme.display.Sprite;

class SystemsConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        injector = new Injector();
        context = new Context(injector)
            .configure(SystemsConfig)
            .start(new Sprite());
    }

    @Test public function systemsIsInjected()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isNotNull(systems);
    }
}