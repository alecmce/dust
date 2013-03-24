package dust.canvas.data;

import nme.geom.Matrix;
import dust.geom.data.Position;
import nme.display.Graphics;
import dust.entities.api.Entity;
import nme.display.BitmapData;

class BitmapPainter extends Painter
{
    static var matrix:Matrix = new Matrix();

    public var bitmap:BitmapData;

    public function new(bitmap:BitmapData)
        this.bitmap = bitmap

    override public function draw(entity:Entity, graphics:Graphics)
    {
        var position = entity.get(Position);
        var width = bitmap.width;
        var height = bitmap.height;

        graphics.beginBitmapFill(bitmap, matrix, false, false);
        graphics.drawRect(-width * 0.5, -height * 0.5, width, height);
        graphics.endFill();
    }
}
