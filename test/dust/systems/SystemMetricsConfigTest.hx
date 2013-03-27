package dust.systems;

import nme.display.Sprite;
import dust.context.Context;
import dust.Injector;

class SystemMetricsConfigTest
{
    @Test public function sanityTestThatSystemMetricsConfigBoots()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(SystemMetricsConfig)
            .start(new Sprite());
    }
}
