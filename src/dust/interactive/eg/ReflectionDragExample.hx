package dust.interactive.eg;

import dust.interactive.config.ReflectionDecorator;
import dust.interactive.config.OffsetDecorator;
import dust.interactive.data.Reflection;
import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.interactive.data.MouseInteractive;
import dust.canvas.data.PrioritizedPainter;
import dust.canvas.PrioritizedPaintersConfig;
import dust.canvas.data.Paint;
import dust.entities.EntitiesConfig;
import dust.camera.data.Camera;
import dust.canvas.data.Paint;
import dust.canvas.data.Painter;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.api.Entities;
import dust.interactive.data.Draggable;
import dust.geom.data.Position;

import nme.display.Graphics;

class ReflectionDragExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var camera:Camera;
    @inject public var reflectionDecorator:ReflectionDecorator;
    @inject public var offsetDecorator:OffsetDecorator;

    public function dependencies():Array<Class<Config>>
    {
        return [EntitiesConfig, InteractiveConfig, PrioritizedPaintersConfig];
    }

    public function configure()
    {
        var center = makeEntity(0, 0, 0x1E90FF);
        var left = makeEntity(-200, 66, 0xFF8800);
        var right = makeEntity(200, -66, 0xFF8800);

        reflectionDecorator.apply(left, center, right);
        reflectionDecorator.apply(right, center, left);
        offsetDecorator.apply(center, left);
        offsetDecorator.apply(center, right);
    }

        function makeEntity(x:Float, y:Float, color:Int):Entity
        {
            var position = new Position(x, y);
            var paint = new Paint().setFill(color);
            var painter = new DrawSquarePainter(paint, position);
            var priority = new PrioritizedPainter(painter, 0);
            var interactive = new MouseInteractive(isMouseOver);
            var drag = new Draggable();

            var entity = entities.require();
            entity.add(camera);
            entity.add(position);
            entity.add(priority);
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