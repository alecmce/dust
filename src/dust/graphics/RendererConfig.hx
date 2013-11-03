package dust.graphics;

import dust.context.Config;
import dust.context.DependentConfig;
import dust.graphics.control.XYPlaneSurfaceFactory;
import dust.systems.impl.SystemMap;

class RendererConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:SystemMap;

    public function dependencies():Array<Class<Config>>
    {
        var list = new Array<Class<Config>>();
        #if flash
            list.push(dust.graphics.renderer.impl.flash.FlashRendererConfig);
        #else
            list.push(dust.graphics.renderer.impl.opengl.OpenGLRendererConfig);
        #end
        return list;
    }

    public function configure()
    {
        injector.mapSingleton(XYPlaneSurfaceFactory);
    }
}
