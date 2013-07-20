package dust.interactive.eg;

import dust.interactive.control.TouchInteractiveFactory;
import dust.camera.data.Camera;
import dust.graphics.data.Paint;
import dust.graphics.data.Paint;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.Entity;
import dust.entities.Entities;
import dust.entities.EntitiesConfig;
import dust.geom.data.Position;
import dust.interactive.control.OffsetDecorator;
import dust.interactive.data.Draggable;
import dust.interactive.data.TouchInteractive;

using dust.graphics.PaintersUtil;

class OffsetDragExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var camera:Camera;
    @inject public var decorator:OffsetDecorator;
    @inject public var factory:TouchInteractiveFactory;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, InteractiveConfig, PaintersConfig];

    public function configure()
    {
        var center = makeEntity(0, 0, 0x1E90FF);
        var offset = makeEntity(100, -100, 0xFF8800);
        decorator.apply(center, offset);
    }

        function makeEntity(x:Float, y:Float, color:Int):Entity
        {
            var position = new Position(x, y);
            var paint = new Paint().setFill(color);
            var painter = new DrawSquarePainter(paint, position);
            var interactive = factory.makeSquare(10);
            var drag = new Draggable();

            var entity = entities.require();
            entity.add(camera);
            entity.add(position);
            entity.add(interactive);
            entity.add(drag);
            entity.addPainter(painter);
            return entity;
        }
}