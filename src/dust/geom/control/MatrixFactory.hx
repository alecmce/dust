package dust.geom.control;

import dust.math.trig.Trig;
import dust.math.AnglesUtil;
import flash.Vector;
import flash.geom.Matrix3D;

using dust.math.AnglesUtil;

class MatrixFactory
{
    @inject public var trig:Trig;

    public function make2D(x:Float, y:Float, scale:Float = 1.0, rotation:Float = 0.0):Matrix3D
    {
        trig.setAngle(rotation.toRadians());
        var c = trig.getCosine() * scale;
        var s = trig.getSine() * scale;

        return fromArray([
            c, -s,  0,  0,
            s,  c,  0,  0,
            0,  0,  1,  0,
            x,  y,  0,  1]);
    }

    public function makeOrthographic(left:Float, right:Float, top:Float, bottom:Float, zNear:Float, zFar:Float):Matrix3D
    {
        var invWidth = 1.0 / (right - left);
        var invHeight = 1.0 / (bottom - top);
        var invDepth = 1.0 / (zFar - zNear);

        var a = 2.0 * invWidth;
        var b = 2.0 * invHeight;
        var c = -2.0 * invDepth;
        var d = -(left + right) * invWidth;
        var e = -(top + bottom) * invHeight;
        var f = -(zNear + zFar) * invDepth;

        return fromArray([
            a,  0,  0,  0,
            0,  b,  0,  0,
            0,  0,  c,  0,
            d,  e,  f,  1]);
    }

//    public function makePerspective(left:Float, right:Float, top:Float, bottom:Float, near:Float, far:Float):Matrix3D
//    {
//        var invWidth = 1.0 / (right - left);
//        var invHeight = 1.0 / (bottom - top);
//        var invDepth = 1.0 / (far - near);
//
//        var a = 2 * near * invWidth;
//        var b = 2 * near * invHeight;
//        var c = (left + right) * invWidth;
//        var d = (top + bottom) * invHeight;
//        var e = (near + far) * invDepth;
//        var f = -2 * near * far * invDepth;
//
//        return fromArray([
//            a,  0,  0,  0,
//            0,  b,  0,  0,
//            c,  d,  e, -1,
//            0,  0,  f,  0]);
//    }

    public function makePerspective(fieldOfView:Float, aspectRatio:Float, near:Float, far:Float):Matrix3D
    {
        var invDepth = 1.0 / (near - far);

        var a = Math.tan(0.5 * (Math.PI - fieldOfView.toRadians()));
        var b = a / aspectRatio;
        var c = (near + far) * invDepth;
        var d = near * far * invDepth * 2;

        return fromArray([
            b,  0,  0,  0,
            0,  a,  0,  0,
            0,  0,  c, -1,
            0,  0,  d,  0]);
    }

        function fromArray(array:Array<Float>):Matrix3D
        {
            return new Matrix3D(Vector.ofArray(array));
        }
}
