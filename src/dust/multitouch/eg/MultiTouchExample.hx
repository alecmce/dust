package dust.multitouch.eg;

import dust.multitouch.systems.PaintTouchesSystem;
import dust.systems.impl.Systems;
import dust.multitouch.systems.MultiTouchSystem;
import dust.systems.SystemsConfig;
import dust.context.Config;
import dust.Injector;
import dust.context.DependentConfig;

class MultiTouchExample implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [MultiTouchConfig, SystemsConfig]

    public function configure()
    {
        systems
            .map(PaintTouchesSystem)
            .withName('Paint Touches');
    }
}
