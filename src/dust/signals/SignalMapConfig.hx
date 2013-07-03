package dust.signals;

import dust.context.Config;
import dust.signals.SignalMap;

import dust.Injector;

class SignalMapConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
        injector.mapSingleton(SignalMap);
}
