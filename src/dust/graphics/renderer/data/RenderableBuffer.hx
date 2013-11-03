package dust.graphics.renderer.data;

import dust.graphics.data.IndexTriple;

class RenderableBuffer
{
    public var vertices:VertexBuffer;
    var verticesIndex:Int;

    public var triangles:IndexBuffer;
    var trianglesIndex:Int;

    public function new(vertices:VertexBuffer, triangles:IndexBuffer)
    {
        this.vertices = vertices;
        verticesIndex = 0;

        this.triangles = triangles;
        trianglesIndex = 0;
    }

    public function clear()
    {
        verticesIndex = 0;
        trianglesIndex = 0;
    }

    inline public function getFirstVertexIndex():Int
    {
        return verticesIndex;
    }

    inline public function addVertex(data:Array<Float>)
    {
        vertices.setVertex(verticesIndex++, data);
    }

    inline public function addTriangle(zero:Int, triangle:IndexTriple)
    {
        triangles.setTriangle(trianglesIndex++, zero, triangle);
    }

    inline public function getTriangleCount():Int
    {
        return trianglesIndex;
    }
}
