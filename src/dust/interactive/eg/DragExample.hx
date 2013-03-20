package dust.interactive.eg;

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

class DragExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
    {
        return [EntitiesConfig, InteractiveConfig, PrioritizedPaintersConfig];
    }

    public function configure()
    {
        var position = new Position(0, 0);
        var paint = new Paint().setFill(0x1E90FF);
        var painter = new DrawSquarePainter(paint, position);
        var priority = new PrioritizedPainter(painter, 0);
        var interactive = new MouseInteractive(isMouseOver);
        var drag = new Draggable();

        var entity = entities.require();
        entity.add(position);
        entity.add(camera);
        entity.add(priority);
        entity.add(interactive);
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
