package dust.app;

import dust.context.Config;
import dust.signals.SignalMap;

import minject.Injector;

class SignalMapConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
        injector.mapSingleton(SignalMap)
}
