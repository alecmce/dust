package dust.camera.data;

import flash.geom.Matrix;
import flash.display.DisplayObject;
import dust.geom.data.Position;

class Camera
{
    public var screenCenterX:Int;
    public var screenCenterY:Int;

    public var worldX:Float;
    public var worldY:Float;
    public var scalar:Float;

    public function new(screenCenterX:Int, screenCenterY:Int, scalar:Float = 1)
    {
        this.screenCenterX = screenCenterX;
        this.screenCenterY = screenCenterY;
        this.scalar = scalar;

        worldX = 0;
        worldY = 0;
    }

    public function set(worldX:Float, worldY:Float)
    {
        this.worldX = worldX;
        this.worldY = worldY;
    }

    public function offset(worldDX:Float, worldDY:Float)
    {
        worldX += worldDX;
        worldY += worldDY;
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

    inline public function toScreenMatrix(world:Position, matrix:Matrix, offsetX:Float = 0, offsetY:Float = 0, scale:Float = 1):Matrix
    {
        var s = scalar * scale;

        matrix.identity();
        matrix.scale(s, s);
        matrix.tx = screenCenterX + (world.x - offsetX - worldX) * scalar;
        matrix.ty = screenCenterY + (world.y - offsetY - worldY) * scalar;
        return matrix;
    }

    inline public function toWorld(screen:Position, world:Position):Position
    {
        world.x = worldX + (screen.x - screenCenterX) / scalar;
        world.y = worldY + (screen.y - screenCenterY) / scalar;
        return world;
    }

    public function toString():String
        return '[Camera x=$screenCenterX, y=$screenCenterY, world=[x=$worldX, y=$worldY, scalar=$scalar]]';
}
