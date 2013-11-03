package dust.graphics.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Vertex2D;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.SurfaceVertex;
import dust.graphics.data.Surface;

class XYPlaneSurfaceFactory
{
    public function makeSquare(size:Float):Surface
    {
        var s = size / 2;

        var v0 = new SurfaceVertex(new Vertex3D(-s, -s, 0.0), new Vertex2D(0, 0));
        var v1 = new SurfaceVertex(new Vertex3D( s, -s, 0.0), new Vertex2D(1, 0));
        var v2 = new SurfaceVertex(new Vertex3D( s,  s, 0.0), new Vertex2D(1, 1));
        var v3 = new SurfaceVertex(new Vertex3D(-s,  s, 0.0), new Vertex2D(0, 1));
        var vertices = [v0, v1, v2, v3];

        var t0 = new IndexTriple(0, 1, 2);
        var t1 = new IndexTriple(0, 2, 3);
        var triangles = [t0, t1];

        return new Surface(vertices, triangles);
    }

    public function makeRectangle(left:Float, top:Float, width:Float, height:Float):Surface
    {
        var right = left + width;
        var bottom = top + height;

        var v0 = new SurfaceVertex(new Vertex3D(left, top, 0.0), new Vertex2D(0, 0));
        var v1 = new SurfaceVertex(new Vertex3D(right, top, 0.0), new Vertex2D(1, 0));
        var v2 = new SurfaceVertex(new Vertex3D(right, bottom, 0.0), new Vertex2D(1, 1));
        var v3 = new SurfaceVertex(new Vertex3D(left, bottom, 0.0), new Vertex2D(0, 1));
        var vertices = [v0, v1, v2, v3];

        var t0 = new IndexTriple(0, 1, 2);
        var t1 = new IndexTriple(0, 2, 3);
        var triangles = [t0, t1];

        return new Surface(vertices, triangles);
    }
}
