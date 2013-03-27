package dust.signals;

import dust.signals.SignalMapConfig;
import dust.signals.SignalMap;
import dust.Injector;
import dust.context.Config;
import nme.display.Sprite;
import dust.context.Context;

class SignalMapConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        context = new Context()
            .configure(SignalMapConfig)
            .start(new Sprite());
        injector = context.injector;
    }

    @Test public function commandMapIsInjected()
    {
        var signalMap:SignalMap = injector.getInstance(SignalMap);
        Assert.isNotNull(signalMap);
    }
}