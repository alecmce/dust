package dust.graphics.data;

import flash.Vector;
import flash.geom.Vector3D;
import flash.geom.Matrix3D;

class Quaternion
{
    public var w:Float;
    public var x:Float;
    public var y:Float;
    public var z:Float;

    public function new(w:Float = 1.0, x:Float = 0.0, y:Float = 0.0, z:Float = 0.0)
    {
        this.w = w;
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public function reset(w:Float = 0.0, x:Float = 0.0, y:Float = 0.0, z:Float = 0.0):Quaternion
    {
        this.w = w;
        this.x = x;
        this.y = y;
        this.z = z;

        return this;
    }

    public function setTo(quaternion:Quaternion):Quaternion
    {
        this.w = quaternion.w;
        this.x = quaternion.x;
        this.y = quaternion.y;
        this.z = quaternion.z;

        return this;
    }

    public function clone():Quaternion
    {
        return new Quaternion(w, x, y, z);
    }

    public function add(q:Quaternion)
    {
        w += q.w;
        x += q.x;
        y += q.y;
        z += q.z;
    }

    public function subtract(q:Quaternion)
    {
        w -= q.w;
        x -= q.x;
        y -= q.y;
        z -= q.z;
    }

    public function scale(scalar:Float)
    {
        w *= scalar;
        x *= scalar;
        y *= scalar;
        z *= scalar;
    }

    public function preMultiply(q:Quaternion)
    {
        var mw = w;
        var mx = x;
        var my = y;
        var mz = z;

        w = q.w * mw - q.x * mx - q.y * my - q.z * mz;
        x = q.w * mx + q.x * mw + q.y * mz - q.z * my;
        y = q.w * my - q.x * mz + q.y * mw + q.z * mx;
        z = q.w * mz + q.x * my - q.y * mx + q.z * mw;
    }

    public function postMultiply(q:Quaternion)
    {
        var mw = w;
        var mx = x;
        var my = y;
        var mz = z;

        w = mw * q.w - mx * q.x - my * q.y - mz * q.z;
        x = mw * q.x + mx * q.w + my * q.z - mz * q.y;
        y = mw * q.y - mx * q.z + my * q.w + mz * q.x;
        z = mw * q.z + mx * q.y - my * q.x + mz * q.w;
    }

    public function equals(q:Quaternion):Bool
    {
        return x == q.x && y == q.y && z == q.z && w == q.w;
    }

    public function approx(q:Quaternion, error:Float):Bool
    {
        var dw = w - q.w;
        var dx = x - q.x;
        var dy = y - q.y;
        var dz = z - q.z;

        return dw * dw + dx * dx + dy * dy + dz * dz <= error * error;
    }

    inline public function getSquareMagnitude()
    {
        return w * w + x * x + y * y + z * z;
    }

    inline public function getMagnitude()
    {
        return Math.sqrt(getSquareMagnitude());
    }

    public function dotProduct(q:Quaternion)
    {
        return (w * q.w + x * q.x + y * q.y + z * q.z);
    }

    public function conjugate(output:Quaternion = null):Quaternion
    {
        if (output == null)
           output = new Quaternion();

        output.w = w;
        output.x = -x;
        output.y = -y;
        output.z = -z;
        return output;
    }

    public function invert()
    {
        var scalar = getSquareMagnitude();

        if (scalar == 0)
            w = x = y = z = Math.NaN;
        else
            doInversion(1 / scalar);
    }

        inline function doInversion(invScalar:Float)
        {
            w *= invScalar;
            x *= -invScalar;
            y *= -invScalar;
            z *= -invScalar;
        }

    public function normalize()
    {
        var scalar = getSquareMagnitude();
        if (scalar == 0)
            throw 'Cannot normalize the zero quaternion.';

        scale(1 / Math.sqrt(scalar));
    }

    public function setFromAxisRotation(axis:Vector3D, angle:Float = -1)
    {
        var lenSq = axis.lengthSquared;
        var unit = Math.abs(lenSq - 1) < 0.000001;
        var len = unit ? 1:Math.sqrt(lenSq);

        angle = if (angle == -1)
            len * 0.5;
        else
            angle * 0.5;

        var sinOverLength = if(unit)
            Math.sin(angle);
        else
            Math.sin(angle) / len;

        w = Math.cos(angle);
        x = -sinOverLength * axis.x;
        y = -sinOverLength * axis.y;
        z = -sinOverLength * axis.z;
    }

    public function toAxisRotation():Vector3D
    {
        var angle = 2 * Math.acos(w);
        var axis = new Vector3D(x, y, z);
        axis.normalize();
        axis.scaleBy(angle);
        return axis;
    }

    public function applyToMatrix(matrix:Matrix3D)
    {
        var xx = x * x;
        var yy = y * y;
        var zz = z * z;
        var wx = w * x;
        var wy = w * y;
        var wz = w * z;
        var xy = x * y;
        var xz = x * z;
        var yz = y * z;

        var data = matrix.rawData;
        data[0] = 1 - 2 * (yy + zz);
        data[1] = 2 * (xy + wz);
        data[2] = 2 * (xz - wy);
        data[3] = 0;
        data[4] = 2 * (xy - wz);
        data[5] = 1 - 2 * (xx + zz);
        data[6] = 2 * (yz + wx);
        data[7] = 0;
        data[8] = 2 * (xz + wy);
        data[9] = 2 * (yz - wx);
        data[10] = 1 - 2 * (xx + yy);
        data[11] = 0;
        data[12] = 0;
        data[13] = 0;
        data[14] = 0;
        data[15] = 1;
    }

    public function toString():String
    {
        return '[Quaternion w=$w, x=$x, y=$y, z=$z]';
    }
}