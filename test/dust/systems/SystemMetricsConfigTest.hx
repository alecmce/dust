package dust.systems;

import flash.display.Sprite;
import dust.context.Context;
import dust.Injector;

class SystemMetricsConfigTest
{
    @Test public function sanityTestThatSystemMetricsConfigBoots()
    {
        var context = new Context()
            .configure(SystemMetricsConfig)
            .start(new Sprite());
    }
}
