package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Solid;
import dust.graphics.data.Vertex3D;

using dust.ArrayUtil;

class DodecahedronFactory
{
    @inject public var solidFactory:PlatonicSolidFactory;

    var root5:Float;
    var phi:Float;
    var phibar:Float;

    public function new()
    {
        root5 = Math.sqrt(5);
        phi = (1 + root5) / 2;
        phibar = (1 - root5) / 2;
    }

    public function make(size:Float):Solid
    {
        return solidFactory.make(size, makeVertices, makeFaceIndexMatrix, makeTriangles, 5);
    }

        function makeVertices(size:Float):Array<Vertex3D>
        {
            var X = size / (root5 - 1);
            var Y = X * phi;
            var Z = X * phibar;
            var S = -X;
            var T = -Y;
            var W = -Z;

            return [new Vertex3D(X, X, X),
                    new Vertex3D(X, X, S),
                    new Vertex3D(X, S, X),
                    new Vertex3D(X, S, S),
                    new Vertex3D(S, X, X),
                    new Vertex3D(S, X, S),
                    new Vertex3D(S, S, X),
                    new Vertex3D(S, S, S),
                    new Vertex3D(W, Y, 0),
                    new Vertex3D(Z, Y, 0),
                    new Vertex3D(W, T, 0),
                    new Vertex3D(Z, T, 0),
                    new Vertex3D(Y, 0, W),
                    new Vertex3D(Y, 0, Z),
                    new Vertex3D(T, 0, W),
                    new Vertex3D(T, 0, Z),
                    new Vertex3D(0, W, Y),
                    new Vertex3D(0, Z, Y),
                    new Vertex3D(0, W, T),
                    new Vertex3D(0, Z, T)];
        }

        function makeFaceIndexMatrix():Array<Array<Int>>
        {
            return [[ 1,  8,  0, 12, 13],  // 1
                    [14, 15,  5,  9,  4],  // 2
                    [12, 13,  3, 10,  2],  // 3
                    [15, 14,  6, 11,  7],  // 4
                    [17, 16,  0, 12,  2],  // 5
                    [18, 19,  3, 13,  1],  // 6
                    [16, 17,  6, 14,  4],  // 7
                    [ 7, 15,  5, 18, 19],  // 8
                    [ 9,  8,  0, 16,  4],  // 9
                    [10, 11,  6, 17,  2],  // 10
                    [ 8,  9,  5, 18,  1],  // 11
                    [11, 10,  3, 19,  7]]; // 12
        }

        function makeTriangles():Array<IndexTriple>
        {
            return [new IndexTriple(0, 1, 2),
                    new IndexTriple(0, 2, 3),
                    new IndexTriple(0, 3, 4)];
        }
}