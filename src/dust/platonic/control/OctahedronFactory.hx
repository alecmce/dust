package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.Solid;

class OctahedronFactory
{
    @inject public var solidFactory:PlatonicSolidFactory;

    var root2:Float;

    public function new()
    {
        root2 = Math.sqrt(2);
    }

    public function make(size:Float):Solid
    {
        return solidFactory.make(size, makeVertices, makeFaceIndexMatrix, makeTriangles, 3);
    }

        function makeVertices(size:Float):Array<Vertex3D>
        {
            var p = size / root2;
            var n = -p;

            var a = new Vertex3D(p, 0, 0);
            var b = new Vertex3D(0, p, 0);
            var c = new Vertex3D(n, 0, 0);
            var d = new Vertex3D(0, n, 0);
            var e = new Vertex3D(0, 0, p);
            var f = new Vertex3D(0, 0, n);

            return [a,b,c,d,e,f];
        }

        function makeFaceIndexMatrix():Array<Array<Int>>
        {
            var A = [0, 1, 4];
            var B = [1, 2, 4];
            var C = [2, 3, 4];
            var D = [3, 0, 4];
            var E = [0, 3, 5];
            var F = [3, 2, 5];
            var G = [2, 1, 5];
            var H = [1, 0, 5];

            return [A, B, C, D, E, F, G, H];
        }

        function makeTriangles():Array<IndexTriple>
        {
            return [new IndexTriple(0, 1, 2)];
        }
}