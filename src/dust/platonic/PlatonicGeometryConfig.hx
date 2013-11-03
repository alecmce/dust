package dust.platonic;

import dust.geom.GeometryConfig;
import dust.math.MathConfig;
import dust.context.DependentConfig;
import dust.platonic.control.FacePositionsCache;
import dust.platonic.control.PlatonicSolidFactory;
import dust.geom.control.RegularPolygonFactory;
import dust.platonic.control.TetrahedronFactory;
import dust.platonic.control.CubeFactory;
import dust.platonic.control.OctahedronFactory;
import dust.platonic.control.IcosahedronFactory;
import dust.platonic.control.DodecahedronFactory;
import dust.context.Config;

class PlatonicGeometryConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
    {
        return [GeometryConfig, MathConfig];
    }

    public function configure()
    {
        injector.mapSingleton(RegularPolygonFactory);
        injector.mapSingleton(FacePositionsCache);
        injector.mapSingleton(PlatonicSolidFactory);

        injector.mapSingleton(TetrahedronFactory);
        injector.mapSingleton(CubeFactory);
        injector.mapSingleton(OctahedronFactory);
        injector.mapSingleton(DodecahedronFactory);
        injector.mapSingleton(IcosahedronFactory);
    }
}
