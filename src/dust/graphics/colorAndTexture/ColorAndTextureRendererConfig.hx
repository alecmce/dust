package dust.graphics.colorAndTexture;

import dust.graphics.colorAndTexture.control.StartColorAndTextureRendererCommand;
import dust.graphics.colorAndTexture.control.StartColorAndTextureRendererSignal;
import dust.commands.CommandMap;
import dust.commands.CommandMapConfig;
import dust.graphics.colorAndTexture.control.ColorAndTextureProgramFactory;
import dust.graphics.colorAndTexture.control.ColorAndTextureRenderableBufferFactory;
import dust.graphics.colorAndTexture.data.ColorAndTextureSetup;
import dust.systems.SystemsConfig;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.camera.CameraConfig;

class ColorAndTextureRendererConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var commands:CommandMap;

    public function dependencies():Array<Class<Config>>
    {
        return [RendererConfig, SystemsConfig, CommandMapConfig, CameraConfig];
    }

    public function configure()
    {
        injector.mapSingleton(ColorAndTextureSetup);
        injector.mapSingleton(ColorAndTextureRenderableBufferFactory);
        injector.mapSingleton(ColorAndTextureProgramFactory);

        commands.map(StartColorAndTextureRendererSignal, StartColorAndTextureRendererCommand);
    }
}