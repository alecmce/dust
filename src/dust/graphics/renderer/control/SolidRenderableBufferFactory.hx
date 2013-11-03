package dust.graphics.renderer.control;

import dust.graphics.data.SurfaceVertex;
import dust.graphics.data.Surface;
import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.renderer.control.IndexBufferFactory;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.graphics.data.Solid;
import dust.graphics.renderer.data.VertexBuffer;
import dust.graphics.renderer.data.IndexBuffer;

using dust.ArrayUtil;

class SolidRenderableBufferFactory
{
    @inject public var vertexBufferFactory:VertexBufferFactory;
    @inject public var indexBufferFactory:IndexBufferFactory;

    public function make(solid:Solid, getExtra:Int->Array<Float>):RenderableBuffer
    {
        return new RenderableBuilder(vertexBufferFactory, indexBufferFactory)
            .build(solid, getExtra);
    }
}

class RenderableBuilder
{
    inline static var FACE_TRIANGLE_VERTICES:Int = 5;

    var vertexBufferFactory:VertexBufferFactory;
    var indexBufferFactory:IndexBufferFactory;

    var solid:Solid;
    var getExtra:Int->Array<Float>;

    var extras:Array<Array<Float>>;
    var vertexIndex:Int;
    var vertices:VertexBuffer;
    var triangleIndex:Int;
    var triangles:IndexBuffer;

    public function new(vertexBufferFactory:VertexBufferFactory, indexBufferFactory:IndexBufferFactory)
    {
        this.vertexBufferFactory = vertexBufferFactory;
        this.indexBufferFactory = indexBufferFactory;
    }

    public function build(solid:Solid, getExtra:Int->Array<Float>):RenderableBuffer
    {
        this.solid = solid;
        this.getExtra = getExtra;

        makeExtras();
        makeBuffers();
        populate();

        return new RenderableBuffer(vertices, triangles);
    }

        function makeExtras()
        {
            var count = solid.getFaces().length;

            extras = new Array<Array<Float>>();
            for (i in 0...count)
                extras.push(getExtra(i));
            return extras;
        }

        function makeBuffers()
        {
            vertices = vertexBufferFactory.make(getVertexCount(), getDataPerVertex());
            vertexIndex = 0;

            triangles = indexBufferFactory.make(FACE_TRIANGLE_VERTICES * getTriangleCount());
            triangleIndex = 0;
        }

            function getVertexCount():Int
            {
                var faces = solid.getFaces();

                var count = 0;
                for (face in faces)
                    count += face.getVertices().length;
                return count;
            }

            function getDataPerVertex():Int
            {
                return FACE_TRIANGLE_VERTICES + (extras[0] != null ? extras[0].length : 0);
            }

            function getTriangleCount():Int
            {
                var faces = solid.getFaces();

                var count = 0;
                for (face in faces)
                    count += face.getTriangles().length;
                return count;
            }

        function populate()
        {
            var faces = solid.getFaces();
            for (i in 0...faces.length)
                populateFace(faces[i], i);
        }

            function populateFace(face:Surface, index:Int)
            {
                var zeroIndex = vertexIndex;

                for (v in face.getVertices())
                    vertices.setVertex(vertexIndex++, getVertexData(v, extras[index]));

                for (triple in face.getTriangles())
                    triangles.setTriangle(triangleIndex++, zeroIndex, triple);
            }

                function getVertexData(v:SurfaceVertex, extras:Array<Float>):Array<Float>
                {
                    return [v.vertex.x, v.vertex.y, v.vertex.z, v.texture.x, v.texture.y].concat(extras);
                }
}
