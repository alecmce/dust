package dust.signals;

import dust.signals.SignalMapConfig;
import dust.signals.SignalMap;
import minject.Injector;
import dust.context.Config;
import nme.display.Sprite;
import dust.context.Context;

class SignalMapConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        injector = new Injector();
        context = new Context(injector)
            .configure(SignalMapConfig)
            .start(new Sprite());
    }

    @Test public function commandMapIsInjected()
    {
        var signalMap:SignalMap = injector.getInstance(SignalMap);
        Assert.isNotNull(signalMap);
    }
}