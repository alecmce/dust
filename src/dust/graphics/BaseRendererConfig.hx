package dust.graphics;

import dust.geom.GeometryConfig;
import dust.systems.SystemsConfig;
import dust.entities.EntitiesConfig;
import dust.context.Config;
import dust.graphics.renderer.control.SolidRenderableBufferFactory;
import dust.graphics.renderer.control.ConstrainToPartialTexture;
import dust.graphics.renderer.control.ConstrainToPartialTexture;
import dust.graphics.renderer.control.SolidRenderableBufferFactory;
import dust.context.DependentConfig;

class BaseRendererConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
    {
        return [EntitiesConfig, SystemsConfig, GeometryConfig];
    }

    public function configure()
    {
        injector.mapSingleton(ConstrainToPartialTexture);
        injector.mapSingleton(SolidRenderableBufferFactory);
    }
}
