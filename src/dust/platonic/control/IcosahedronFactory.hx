package dust.platonic.control;

import dust.graphics.data.IndexTriple;
import dust.graphics.data.Vertex3D;
import dust.graphics.data.Solid;

class IcosahedronFactory
{
    @inject public var factory:PlatonicSolidFactory;

    var root5:Float;

    public function new()
    {
        root5 = Math.sqrt(5);
    }

    public function make(size:Float):Solid
    {
        return factory.make(size, makeVertices, makeFaceIndexMatrix, makeTriangles, 3);
    }

        function makeVertices(size:Float):Array<Vertex3D>
        {
            var n = size / 2;
            var X = n * (1 + root5) / 2;
            var Y = -X;
            var Z = n;
            var W = -n;

            var a = new Vertex3D(X,Z,0);
            var b = new Vertex3D(Y,Z,0);
            var c = new Vertex3D(X,W,0);
            var d = new Vertex3D(Y,W,0);
            var e = new Vertex3D(Z,0,X);
            var f = new Vertex3D(Z,0,Y);
            var g = new Vertex3D(W,0,X);
            var h = new Vertex3D(W,0,Y);
            var i = new Vertex3D(0,X,Z);
            var j = new Vertex3D(0,Y,Z);
            var k = new Vertex3D(0,X,W);
            var l = new Vertex3D(0,Y,W);

            return [a,b,c,d,e,f,g,h,i,j,k,l];
        }

        function makeFaceIndexMatrix():Array<Array<Int>>
        {
            var A = [ 0,  8,  4];
            var B = [ 0,  5, 10];
            var C = [ 2,  4,  9];
            var D = [ 2, 11,  5];
            var E = [ 1,  6,  8];
            var F = [ 1, 10,  7];
            var G = [ 3,  9,  6];
            var H = [ 3,  7, 11];
            var I = [ 0, 10,  8];
            var J = [ 1,  8, 10];
            var K = [ 2,  9, 11];
            var L = [ 3, 11,  9];
            var M = [ 4,  2,  0];
            var N = [ 5,  0,  2];
            var O = [ 6,  1,  3];
            var P = [ 7,  3,  1];
            var Q = [ 8,  6,  4];
            var R = [ 9,  4,  6];
            var S = [10,  5,  7];
            var T = [11,  7,  5];

            return [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T];
        }

        function makeTriangles():Array<IndexTriple>
        {
            return [new IndexTriple(0, 1, 2)];
        }
}