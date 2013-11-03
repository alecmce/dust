package dust.graphics.colorAndTexture.eg;

import dust.graphics.colorAndTexture.control.StartColorAndTextureRendererSignal;
import dust.graphics.renderer.control.TextureFactory;
import dust.camera.data.Camera;
import dust.graphics.renderer.data.RendererTexture;
import snake.stars.eg.AutoRotateCameraConfig;
import dust.tween.curves.Quad;
import dust.gui.data.Color;
import dust.tween.TweenConfig;
import dust.tween.TweensUtil;
import dust.tween.data.Tween;
import dust.systems.impl.Systems;
import dust.math.MathConfig;
import dust.math.Random;
import dust.systems.System;
import dust.entities.Entity;
import dust.context.Config;
import dust.gui.data.Color;
import dust.context.DependentConfig;

using dust.tween.TweensUtil;

class ColorAndTextureGenerativeExample implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;
    @inject public var textureFactory:TextureFactory;
    @inject public var camera:Camera;

    @inject public var startRenderer:StartColorAndTextureRendererSignal;

    public function dependencies():Array<Class<Config>>
    {
        return [ColorAndTextureRendererConfig, MathConfig, TweenConfig, AutoRotateCameraConfig];
    }

    public function configure()
    {
        startRenderer.dispatch(makeRendererTexture());

        camera.isPerspective = false;
        injector.mapSingleton(ColorAndTextureTileFactory);
        systems.map(MakeTileSystem, 0);
    }

        function makeRendererTexture():RendererTexture
        {
            var asset = openfl.Assets.getBitmapData('assets/numbers.png');
            var data = openfl.Assets.getText('assets/numbers.json');
            return textureFactory.make(asset, data);
        }
}

class MakeTileSystem implements System
{
    @inject public var factory:ColorAndTextureTileFactory;
    @inject public var random:Random;

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        var x = random.floatInRange(-500, 500);
        var y = random.floatInRange(-350, 350);
        var z = random.float(500);
        var size = random.floatInRange(50, 100);
        var color = random.color();
        var tx = random.int(4);
        var ty = random.int(4);

        var entity = factory.make(x, y, z, size, color, tx, ty);
        entity.addTween(makeTween());
    }

        function makeTween():Tween
        {
            var tween = new Tween(1.0, 0.0, 2.0);
            tween.onUpdate = onUpdate;
            tween.onComplete = onComplete;
            tween.ease = Quad.easeOut;
            return tween;
        }

            function onUpdate(entity:Entity, value:Float)
            {
                entity.get(Color).alpha = value;
            }

            function onComplete(entity:Entity)
            {
                entity.dispose();
            }
}