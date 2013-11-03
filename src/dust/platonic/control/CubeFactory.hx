package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.Solid;

class CubeFactory
{
    @inject public var factory:PlatonicSolidFactory;

    public function make(size:Float):Solid
    {
        return factory.make(size, makeVertices, makeFaceIndexMatrix, makeTriangles, 4);
    }

        function makeVertices(size:Float)
        {
            var pos = 0.5 * size;
            var neg = -0.5 * size;

            var a = new Vertex3D(neg,neg,neg);
            var b = new Vertex3D(pos,neg,neg);
            var c = new Vertex3D(pos,pos,neg);
            var d = new Vertex3D(neg,pos,neg);
            var e = new Vertex3D(neg,neg,pos);
            var f = new Vertex3D(pos,neg,pos);
            var g = new Vertex3D(pos,pos,pos);
            var h = new Vertex3D(neg,pos,pos);

            return [a,b,c,d,e,f,g,h];
        }

        function makeFaceIndexMatrix():Array<Array<Int>>
        {
            var A = [3,2,1,0];
            var B = [0,1,5,4];
            var C = [1,2,6,5];
            var D = [2,3,7,6];
            var E = [3,0,4,7];
            var F = [4,5,6,7];

            return [A,B,C,D,E,F];
        }

        function makeTriangles():Array<IndexTriple>
        {
            return [new IndexTriple(0, 1, 2),
                    new IndexTriple(0, 2, 3)];
        }
}