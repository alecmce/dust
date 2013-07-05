package dust.graphics;

import dust.camera.CameraConfig;
import dust.camera.data.Camera;
import dust.graphics.data.Painters;
import dust.graphics.GraphicsConfig;
import dust.graphics.systems.PainterSystem;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.collections.control.CollectionMap;
import dust.entities.Entity;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.graphics.data.Paint;

import dust.Injector;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;

class PaintersConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;
    @inject public var collectionMap:CollectionMap;

    var canvas:Sprite;

    public function dependencies():Array<Class<Config>>
        return [GraphicsConfig, SystemsConfig, CameraConfig];

    public function configure()
    {
        systems
            .map(PainterSystem)
            .toCollection([Camera, Painters], sorter)
            .withName("Painters");
    }

        function sorter(a:Entity, b:Entity):Int
            return a.get(Painters).getPriority() - b.get(Painters).getPriority();
}
