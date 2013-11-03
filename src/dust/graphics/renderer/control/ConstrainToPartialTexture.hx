package dust.graphics.renderer.control;

import dust.graphics.data.Solid;
import dust.graphics.data.Vertex2D;
import flash.geom.Rectangle;
import dust.graphics.data.Surface;

class ConstrainToPartialTexture
{
    public function constrainSolid(solid:Solid, getRect:Int->Rectangle)
    {
        var faces = solid.getFaces();

        for (i in 0...faces.length)
            constrainFace(faces[i], getRect(i));
    }

    public function constrainFace(surface:Surface, rect:Rectangle)
    {
        var vertices = surface.getVertices();

        for (vertex in vertices)
            vertex.texture = constrainTexturePosition(vertex.texture, rect);
    }

        function constrainTexturePosition(position:Vertex2D, rect:Rectangle):Vertex2D
        {
            var x = rect.left + position.x * rect.width;
            var y = rect.top + position.y * rect.height;
            return new Vertex2D(x, y);
        }
}
