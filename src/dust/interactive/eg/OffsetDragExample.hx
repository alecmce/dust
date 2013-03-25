package dust.interactive.eg;

import dust.camera.data.Camera;
import dust.graphics.data.Paint;
import dust.graphics.data.Paint;
import dust.graphics.data.Painter;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.EntitiesConfig;
import dust.geom.data.Position;
import dust.interactive.control.OffsetDecorator;
import dust.interactive.data.Draggable;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.Offsets;

import nme.display.Graphics;

class OffsetDragExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var camera:Camera;
    @inject public var decorator:OffsetDecorator;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, InteractiveConfig, PaintersConfig]

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
            var interactive = new MouseInteractive(isMouseOver);
            var drag = new Draggable();

            var entity = entities.require();
            entity.add(camera);
            entity.add(position);
            entity.addAsType(painter, Painter);
            entity.add(interactive);
            entity.add(drag);
            return entity;
        }

            function isMouseOver(entity:Entity, mouse:Position):Bool
            {
                var position:Position = entity.get(Position);
                var dx = mouse.x - position.x;
                var dy = mouse.y - position.y;
                return dx >= -10 && dx <= 10 && dy >= -10 && dy <= 10;
            }
}