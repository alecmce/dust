package dust.canvas;

import dust.camera.CameraConfig;
import dust.camera.data.Camera;
import dust.canvas.CanvasConfig;
import dust.canvas.control.PrioritizedPaintersSystem;
import dust.canvas.data.PrioritizedPainter;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entity;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.canvas.data.Paint;

import minject.Injector;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.display.DisplayObjectContainer;

class PrioritizedPaintersConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;
    @inject public var collectionMap:CollectionMap;

    var canvas:Sprite;

    public function dependencies():Array<Class<Config>>
        return [CanvasConfig, SystemsConfig, CameraConfig]

    public function configure()
    {
        systems
            .map(PrioritizedPaintersSystem)
            .toCollection([Camera, PrioritizedPainter])
            .withSorter(sorter)
            .withName("PrioritizedPainters");
    }

        function sorter(a:Entity, b:Entity):Int
            return a.get(PrioritizedPainter).priority - b.get(PrioritizedPainter).priority
}
