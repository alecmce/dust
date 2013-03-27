package dust.math;

import dust.math.trig.HighPrecisionFastTrig;
import dust.math.trig.LowPrecisionFastTrig;
import dust.math.trig.Trig;
import dust.Injector;

import dust.context.Config;

class MathConfig implements Config
{
    @inject
    public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(Random);
        injector.mapSingletonOf(Trig, HighPrecisionFastTrig);
    }
}
