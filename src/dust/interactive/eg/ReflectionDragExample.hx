package dust.interactive.eg;

import dust.interactive.control.TouchInteractiveFactory;
import dust.interactive.control.ReflectionDecorator;
import dust.interactive.control.OffsetDecorator;
import dust.interactive.data.Reflection;
import dust.interactive.data.Offsets;
import dust.entities.api.Entity;
import dust.interactive.data.TouchInteractive;
import dust.graphics.PaintersConfig;
import dust.graphics.data.Paint;
import dust.entities.EntitiesConfig;
import dust.camera.data.Camera;
import dust.graphics.data.Paint;
import dust.graphics.data.Painters;
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
    @inject public var factory:TouchInteractiveFactory;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, InteractiveConfig, PaintersConfig]

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
            var drag = new Draggable();

            var entity = entities.require();
            entity.add(camera);
            entity.add(position);
            entity.add(new Painters().add(painter));
            entity.add(factory.makeSquare(10));
            entity.add(drag);
            return entity;
        }
}