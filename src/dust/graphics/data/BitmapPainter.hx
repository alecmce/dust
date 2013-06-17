package dust.graphics.data;

import dust.components.Component;
import nme.geom.ColorTransform;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.entities.api.Entity;

import nme.display.BitmapData;
import nme.display.Graphics;
import nme.geom.Matrix;

class BitmapPainter
    extends Component,
    implements Painter
{
    static var matrix:Matrix = new Matrix();

    public var bitmap:BitmapData;
    public var scale:Float;
    public var alpha:Float;

    public function new(bitmap:BitmapData)
    {
        this.bitmap = bitmap;
        this.scale = 1;
    }

    public function setScale(scale:Float):BitmapPainter
    {
        this.scale = scale;
        return this;
    }

    public function fade()
    {
        bitmap.colorTransform(bitmap.rect, new ColorTransform(1.0, 1.0, 1.0, 0.95));
    }

    public function draw(entity:Entity, graphics:Graphics)
    {
        var position:Position = entity.get(Position);
        var camera:Camera = entity.get(Camera);
        var scalar = camera.scalar * scale;
        var width = bitmap.width;
        var height = bitmap.height;

        camera.toScreenMatrix(position, matrix, width * 0.5 * scale, height * 0.5 * scale, scale);
        graphics.lineStyle();
        graphics.beginBitmapFill(bitmap, matrix, false, true);
        graphics.drawRect(matrix.tx, matrix.ty, width * scalar, height * scalar);
        graphics.endFill();
    }
}
