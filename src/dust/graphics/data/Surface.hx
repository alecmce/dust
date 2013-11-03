package dust.graphics.data;

class Surface
{
    var vertices:Array<SurfaceVertex>;
    var triangles:Array<IndexTriple>;

    public function new(vertices:Array<SurfaceVertex>, triangles:Array<IndexTriple>)
    {
        this.vertices = vertices;
        this.triangles = triangles;
    }

    public function getVertices():Array<SurfaceVertex>
    {
        return vertices;
    }

    public function getTriangles():Array<IndexTriple>
    {
        return triangles;
    }

    public function toString():String
    {
        return '[Surface vertices:${vertices.join(",")} triangles:${triangles.join(",")}]';
    }
}