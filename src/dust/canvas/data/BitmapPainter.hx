package dust.canvas.data;

import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.entities.api.Entity;

import nme.display.BitmapData;
import nme.display.Graphics;
import nme.geom.Matrix;

class BitmapPainter extends Painter
{
    static var matrix:Matrix = new Matrix();

    public var bitmap:BitmapData;
    public var scaleBitmap:Bool;

    public function new(bitmap:BitmapData)
        this.bitmap = bitmap

    override public function draw(entity:Entity, graphics:Graphics)
    {
        var position:Position = entity.get(Position);
        var camera:Camera = entity.get(Camera);
        var scalar = camera.scalar;

        var width = bitmap.width;
        var height = bitmap.height;

        camera.toScreenMatrix(position, matrix, width * 0.5, height * 0.5);
        graphics.lineStyle();
        graphics.beginBitmapFill(bitmap, matrix, false, true);
        graphics.drawRect(matrix.tx, matrix.ty, width * scalar, height * scalar);
        graphics.endFill();
    }
}
