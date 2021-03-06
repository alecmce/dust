package dust.graphics.data;

import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.entities.Entity;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Matrix;

class NoScaleBitmapPainter
    implements Painter
{
    static var matrix:Matrix = new Matrix();

    public var bitmap:BitmapData;

    var screen:Position;

    public function new(bitmap:BitmapData)
    {
        this.bitmap = bitmap;
        this.screen = new Position();
    }

    public function draw(entity:Entity, graphics:Graphics)
    {
        var camera:Camera = entity.get(Camera);
        var world:Position = entity.get(Position);

        camera.toScreen(world, screen);
        matrix.tx = screen.x - bitmap.width * 0.5;
        matrix.ty = screen.y - bitmap.height * 0.5;

        graphics.beginBitmapFill(bitmap, matrix, false, false);
        graphics.drawRect(matrix.tx, matrix.ty, bitmap.width, bitmap.height);
        graphics.endFill();
    }
}
