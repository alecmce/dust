package dust.systems;

import nme.display.Sprite;
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
