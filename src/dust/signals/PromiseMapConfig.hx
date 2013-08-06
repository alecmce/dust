package dust.signals;

import dust.context.Config;

import dust.Injector;

class PromiseMapConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(PromiseMap);
    }
}
