package dust.interactive.eg;

import dust.interactive.control.TouchInteractiveFactory;
import dust.entities.Entity;
import dust.interactive.data.TouchInteractive;
import dust.graphics.PaintersConfig;
import dust.graphics.data.Paint;
import dust.entities.EntitiesConfig;
import dust.camera.data.Camera;
import dust.graphics.data.Paint;
import dust.graphics.data.Painters;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.Entities;
import dust.interactive.data.Draggable;
import dust.geom.data.Position;

import flash.display.Graphics;

class DragExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var camera:Camera;
    @inject public var factory:TouchInteractiveFactory;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, InteractiveConfig, PaintersConfig];

    public function configure()
    {
        var position = new Position(0, 0);
        var paint = new Paint().setFill(0x1E90FF);
        var painter = new DrawSquarePainter(paint, position);
        var drag = new Draggable();

        var entity = entities.require();
        entity.add(position);
        entity.add(camera);
        entity.add(new Painters().add(painter));
        entity.add(factory.makeSquare(10));
        entity.add(drag);
    }

        function isMouseOver(entity:Entity, mouse:Position):Bool
        {
            var position:Position = entity.get(Position);
            var dx = mouse.x - position.x;
            var dy = mouse.y - position.y;
            return dx >= -10 && dx <= 10 && dy >= -10 && dy <= 10;
        }
}
