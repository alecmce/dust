package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.SurfaceVertex;
import dust.ArrayUtil;
import dust.ArrayUtil;
import dust.graphics.data.Surface;
import dust.graphics.data.Solid;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.Vertex2D;

using dust.ArrayUtil;

class PlatonicSolidFactory
{
    @inject public var positions:FacePositionsCache;

    var vertices:Array<Vertex3D>;
    var triangles:Array<IndexTriple>;

    public function make(size:Float, makeVertices:Float->Array<Vertex3D>, makeFaceIndexMatrix:Void->Array<Array<Int>>, makeTriangles:Void->Array<IndexTriple>, count:Int):Solid
    {
        vertices = makeVertices(size);
        triangles = makeTriangles();

        var surfaces = makeFaces(makeFaceIndexMatrix(), positions.get(count));
        return new Solid(surfaces);
    }

        function makeFaces(faceIndexMatrix:Array<Array<Int>>, positions:Array<Vertex2D>):Array<Surface>
        {
            var list = new Array<Surface>();
            for (faceIndices in faceIndexMatrix)
                list.push(makeFace(faceIndices, positions));
            return list;
        }

            function makeFace(faceIndices:Array<Int>, texturePositions:Array<Vertex2D>):Surface
            {
                var vertices = combine(faceIndices.convert(getVertex), texturePositions);
                return new Surface(vertices, triangles);
            }

                function getVertex(index:Int):Vertex3D
                {
                    return vertices[index];
                }

                function combine(vertices:Array<Vertex3D>, onFace:Array<Vertex2D>):Array<SurfaceVertex>
                {
                    var list = new Array<SurfaceVertex>();
                    for (i in 0...vertices.length)
                        list.push(new SurfaceVertex(vertices[i], onFace[i]));
                    return list;
                }
}