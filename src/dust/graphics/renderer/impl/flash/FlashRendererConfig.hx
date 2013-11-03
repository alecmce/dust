package dust.graphics.renderer.impl.flash;

import dust.signals.PromiseVoid;
import dust.context.AsyncConfig;
import dust.graphics.renderer.control.IndexBufferFactory;
import dust.graphics.renderer.control.OutputBufferFactory;
import com.adobe.utils.AgalLog;
import com.adobe.utils.AgalConstants;
import com.adobe.utils.AgalMiniAssembler;
import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.renderer.impl.flash.FlashProgramFactory;
import dust.graphics.renderer.control.ProgramFactory;
import dust.graphics.renderer.control.TextureFactory;
import dust.context.DependentConfig;
import flash.display.Stage3D;
import dust.graphics.renderer.impl.flash.FlashTextureFactory;
import dust.graphics.renderer.impl.flash.FlashRenderer;
import dust.graphics.renderer.control.Renderer;
import flash.display3D.Context3D;
import flash.display.Stage;
import flash.events.Event;
import dust.context.Config;

class FlashRendererConfig implements DependentConfig implements AsyncConfig
{
    @inject public var injector:Injector;
    @inject public var stage:Stage;

    public var ready:PromiseVoid;

    var context:Context3D;
    var stage3D:Stage3D;

    public function dependencies():Array<Class<Config>>
    {
        return [BaseRendererConfig];
    }

    public function configure()
    {
        ready = new PromiseVoid();

        stage3D = stage.stage3Ds[0];
        if (stage3D.context3D != null)
            init();
        else
            requestContext3D();
    }

        function requestContext3D()
        {
            stage3D.addEventListener(Event.CONTEXT3D_CREATE, onCreate);
            stage3D.requestContext3D();
        }

        function onCreate(event:Event)
        {
            stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onCreate);
            init();
        }

        function init()
        {
            injector.mapSingleton(AgalLog);
            injector.mapSingleton(AgalConstants);
            injector.mapSingleton(AgalMiniAssembler);

            injector.mapSingleton(FlashShaderFactory);

            injector.mapValue(Context3D, stage3D.context3D);
            injector.mapSingletonOf(TextureFactory, FlashTextureFactory);
            injector.mapSingletonOf(ProgramFactory, FlashProgramFactory);
            injector.mapSingletonOf(IndexBufferFactory, FlashIndexBufferFactory);
            injector.mapSingletonOf(OutputBufferFactory, FlashOutputBufferFactory);
            injector.mapSingletonOf(VertexBufferFactory, FlashVertexBufferFactory);
            injector.mapSingletonOf(Renderer, FlashRenderer);

            ready.dispatch();
        }
}
