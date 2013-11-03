package dust.geom;

import dust.math.MathConfig;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.geom.control.MatrixFactory;
import dust.geom.control.QuaternionFactory;

class GeometryConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
    {
        return [MathConfig];
    }

    public function configure()
    {
        injector.mapSingleton(MatrixFactory);
        injector.mapSingleton(QuaternionFactory);
    }
}
