package dust.multitouch.data;

import dust.geom.data.Position;
import dust.camera.data.Camera;

class CameraDragZoomAction extends GestureAction
{
    @inject public var camera:Camera;
    @inject public var gesture:DragZoomGesture;

    var world:Position;

    var startingScale:Float;
    var startingWorldX:Float;
    var startingWorldY:Float;

    var worldGestureCenterX:Float;
    var worldGestureCenterY:Float;

    var centerX:Float;
    var centerY:Float;
    var baseX:Float;
    var baseY:Float;

    public function new()
    {
        super();
        world = new Position();
    }

    override public function start()
    {
        startingScale = camera.scalar;
        startingWorldX = camera.worldX;
        startingWorldY = camera.worldY;

        camera.toWorld(gesture.center, world);
        worldGestureCenterX = world.x;
        worldGestureCenterY = world.y;
    }

    override public function update()
    {
        var scalar = startingScale * gesture.zoomScalar;
        var invScalar = 1 / scalar;

        camera.scalar = scalar;
        camera.worldX = worldGestureCenterX - (gesture.center.x - camera.screenCenterX) * invScalar;
        camera.worldY = worldGestureCenterY - (gesture.center.y - camera.screenCenterY) * invScalar;
    }
}
