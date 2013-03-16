package dust.camera.data;

import nme.display.DisplayObject;
import dust.components.Component;
import dust.position.data.Position;

class Camera extends Component
{
    public var screenCenterX:Int;
    public var screenCenterY:Int;

    public var worldX:Float;
    public var worldY:Float;
    public var scalar:Float;

    public function new(screenCenterX:Int, screenCenterY:Int)
    {
        this.screenCenterX = screenCenterX;
        this.screenCenterY = screenCenterY;
        worldX = 0;
        worldY = 0;
        scalar = 1;
    }

    public function set(worldX:Float, worldY:Float)
    {
        this.worldX = worldX;
        this.worldY = worldY;
    }

    inline public function xyToScreen(x:Float, y:Float, screen:Position):Position
    {
        screen.x = screenCenterX + (x - worldX) * scalar;
        screen.y = screenCenterY + (y - worldY) * scalar;
        return screen;
    }

    inline public function toScreen(world:Position, screen:Position):Position
    {
        screen.x = screenCenterX + (world.x - worldX) * scalar;
        screen.y = screenCenterY + (world.y - worldY) * scalar;
        return screen;
    }

    inline public function toDisplayList(world:Position, object:DisplayObject)
    {
        object.x = screenCenterX + (world.x - worldX) * scalar;
        object.y = screenCenterY + (world.y - worldY) * scalar;
    }

    inline public function toWorld(screen:Position, world:Position):Position
    {
        world.x = worldX + (screen.x - screenCenterX) / scalar;
        world.y = worldY + (screen.y - screenCenterY) / scalar;
        return world;
    }

    public function toString():String
    {
        var world = "[x=" + worldX + ", y=" + worldY + ", scalar=" + scalar + "]";
        return "[Camera x=" + screenCenterX + ", y=" + screenCenterY + ", world=" + world + "]";
    }
}
