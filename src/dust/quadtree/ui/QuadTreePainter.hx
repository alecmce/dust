package dust.quadtree.ui;

import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.quadtree.data.QuadTreeRange;
import dust.camera.data.Camera;
import dust.entities.api.Entity;
import dust.canvas.data.Paint;
import dust.canvas.data.Painter;
import dust.quadtree.data.QuadTree;

import nme.display.Graphics;

class QuadTreePainter extends Painter
{
    var paint:Paint;
    var screen:Position;

    public function new(paint:Paint)
    {
        this.paint = paint;
        this.screen = new Position();
    }

    override public function draw(entity:Entity, graphics:Graphics)
        paint.paint(entity, graphics, drawQuadTree)

        function drawQuadTree(entity:Entity, graphics:Graphics)
        {
            var camera:Camera = entity.get(Camera);
            var quadTree:QuadTree<Dynamic> = entity.get(QuadTree);
            for (range in quadTree.getRanges(quadTree.range))
                drawRange(camera, range, graphics);
        }

            inline function drawRange(camera:Camera, range:QuadTreeRange, graphics:Graphics)
            {
                camera.toScreen(range.position, screen);
                var extent = camera.scalar * range.extent;
                graphics.drawRect(screen.x - extent, screen.y - extent, extent * 2, extent * 2);
            }
}
