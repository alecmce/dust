package dust.graphics.colorAndTexture.eg;

import dust.graphics.colorAndTexture.control.StartColorAndTextureRendererSignal;
import dust.graphics.renderer.control.TextureFactory;
import dust.graphics.renderer.data.RendererTexture;
import snake.stars.eg.AutoRotateCameraConfig;
import dust.gui.data.Color;
import dust.tween.TweenConfig;
import dust.tween.TweensUtil;
import dust.math.MathConfig;
import dust.context.Config;
import dust.gui.data.Color;
import dust.context.DependentConfig;

using dust.tween.TweensUtil;

class ColorAndTextureDepthExample implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var textureFactory:TextureFactory;

    @inject public var startRenderer:StartColorAndTextureRendererSignal;

    var factory:ColorAndTextureTileFactory;

    public function dependencies():Array<Class<Config>>
    {
        return [ColorAndTextureRendererConfig, MathConfig, TweenConfig, AutoRotateCameraConfig];
    }

    public function configure()
    {
        startRenderer.dispatch(makeTexture());

        factory = injector.mapSingleton(ColorAndTextureTileFactory).getInstance(ColorAndTextureTileFactory);
        factory.make(-50, -50, -1500, 100, 0xFF0000, 0, 0).get(Color).alpha = 0.5;
        factory.make(  0,   0, -1000, 100, 0xFF8800, 1, 0).get(Color).alpha = 0.5;
        factory.make( 50,  50,  -500, 100, 0xFFEE00, 2, 0).get(Color).alpha = 0.5;
    }

        function makeTexture():RendererTexture
        {
            var bitmapData = openfl.Assets.getBitmapData('assets/numbers.png');
            var source = openfl.Assets.getText('assets/numbers.json');
            return textureFactory.make(bitmapData, source);
        }
}