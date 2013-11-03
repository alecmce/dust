package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.Solid;
class TetrahedronFactory
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
            var p = size / (2 * root2);
            var n = -p;

            var a = new Vertex3D(p,p,p);
            var b = new Vertex3D(n,n,p);
            var c = new Vertex3D(n,p,n);
            var d = new Vertex3D(p,n,n);

            return [a,b,c,d];
        }

        function makeFaceIndexMatrix():Array<Array<Int>>
        {
            var A = [0,2,1];
            var B = [0,1,3];
            var C = [0,3,2];
            var D = [1,2,3];

            return [A,B,C,D];
        }

        function makeTriangles():Array<IndexTriple>
        {
            return [new IndexTriple(0, 1, 2)];
        }
}