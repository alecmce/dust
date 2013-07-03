package dust.systems;

import dust.systems.SystemsConfig;
import dust.context.Context;
import dust.systems.impl.Systems;

import dust.Injector;
import flash.display.Sprite;

class SystemsConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        context = new Context()
            .configure(SystemsConfig)
            .start(new Sprite());
        injector = context.injector;
    }

    @Test public function systemsIsInjected()
    {
        var systems:Systems = injector.getInstance(Systems);
        Assert.isNotNull(systems);
    }
}