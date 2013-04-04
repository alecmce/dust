package dust.graphics;

import dust.graphics.data.Painter;
import dust.camera.CameraConfig;
import dust.camera.data.Camera;
import dust.graphics.GraphicsConfig;
import dust.graphics.control.PainterSystem;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entity;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.graphics.data.Paint;

import dust.Injector;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.display.DisplayObjectContainer;

class PaintersConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;
    @inject public var collectionMap:CollectionMap;

    var canvas:Sprite;

    public function dependencies():Array<Class<Config>>
        return [GraphicsConfig, SystemsConfig, CameraConfig]

    public function configure()
    {
        systems
            .map(PainterSystem)
            .toCollection([Camera, Painter], sorter)
            .withName("Painters");
    }

        function sorter(a:Entity, b:Entity):Int
            return a.get(Painter).priority - b.get(Painter).priority
}
