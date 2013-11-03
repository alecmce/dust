package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.IndexBufferFactory;
import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.renderer.control.ProgramFactory;
import dust.graphics.renderer.control.TextureFactory;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.graphics.renderer.control.Renderer;
import dust.graphics.renderer.impl.opengl.OpenGLVertexBufferFactory;
import dust.graphics.renderer.impl.opengl.OpenGLProgramFactory;
import dust.graphics.renderer.impl.opengl.OpenGLRenderer;
import flash.display.Stage;
import openfl.display.OpenGLView;

class OpenGLRendererConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var stage:Stage;

    var view:OpenGLView;

    public function dependencies():Array<Class<Config>>
    {
        return [BaseRendererConfig];
    }

    public function configure()
    {
        if (OpenGLView.isSupported)
            configureOpenGLView();
        else
            throw 'OpenGLView is not supported';
    }

        function configureOpenGLView()
        {
            injector.mapValue(OpenGLView, view = new OpenGLView());

            injector.mapSingletonOf(TextureFactory, OpenGLTextureFactory);
            injector.mapSingletonOf(ProgramFactory, OpenGLProgramFactory);
            injector.mapSingletonOf(VertexBufferFactory, OpenGLVertexBufferFactory);
            injector.mapSingletonOf(IndexBufferFactory, OpenGLIndexBufferFactory);
            injector.mapSingletonOf(OutputBufferFactory, OpenGLOutputBufferFactory);
            injector.mapSingletonOf(Renderer, OpenGLRenderer);

            stage.addChild(view);
        }
}
