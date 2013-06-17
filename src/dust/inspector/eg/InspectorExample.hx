package dust.inspector.eg;

import dust.camera.CameraConfig;
import dust.camera.data.Camera;
import dust.inspector.data.Inspector;
import dust.app.data.App;
import dust.geom.data.Position;
import dust.graphics.data.Paint;
import dust.gui.data.Color;
import nme.display.Graphics;
import dust.entities.api.Entity;
import dust.graphics.data.Painter;
import dust.entities.api.Entities;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;

class InspectorExample implements DependentConfig
{
    @inject public var app:App;
    @inject public var entities:Entities;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [InspectorConfig, CameraConfig, PaintersConfig]

    public function configure()
    {
        var paint = new Paint()
            .setFill(0xFF0000)
            .setLine(1, 0xFFFFFF);

        var entity = entities.require();
        entity.add(new Position(0, 0));
        entity.add(camera);
        entity.addAsType(new CirclePainter(100, paint), Painter);
        entity.add(new Inspector());
    }
}

class CirclePainter implements Painter
{
    public var radius:Float;
    public var paint:Paint;

    var screen:Position;

    public function new(radius:Float, paint:Paint)
    {
        this.radius = radius;
        this.paint = paint;

        screen = new Position();
    }

    public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawCircle)

        function drawCircle(entity:Entity, graphics:Graphics)
        {
            var camera:Camera = entity.get(Camera);
            camera.toScreen(entity.get(Position), screen);
            graphics.drawCircle(screen.x, screen.y, radius);
        }
}