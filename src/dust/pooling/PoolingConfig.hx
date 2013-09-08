package dust.pooling;

import dust.pooling.system.SimplePoolFactory;
import dust.pooling.system.PoolFactory;
import dust.context.Config;
import dust.context.DependentConfig;

class PoolingConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
    {
        return [];
    }

    public function configure()
    {
        injector.mapSingletonOf(PoolFactory, SimplePoolFactory);
    }
}