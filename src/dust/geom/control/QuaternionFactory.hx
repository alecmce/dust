package dust.geom.control;

import dust.graphics.data.Quaternion;
import flash.geom.Vector3D;

class QuaternionFactory
{
    public function makeIdentity():Quaternion
    {
        return new Quaternion(1.0, 0.0, 0.0, 0.0);
    }

    public function makeZero():Quaternion
    {
        return new Quaternion(0.0, 0.0, 0.0, 0.0);
    }

    public function makeFromAxialRotation(axis:Vector3D, angle:Float = -1):Quaternion
    {
        var lenSq = axis.lengthSquared;
        var unit = Math.abs(lenSq - 1) < 0.000001;
        var len = unit ? 1 : Math.sqrt(lenSq);

        angle = if (angle == -1)
            len * 0.5;
        else
            angle * 0.5;

        var sinOverLength = if (unit)
            Math.sin(angle);
        else
            Math.sin(angle) / len;

        return new Quaternion(Math.cos(angle), -sinOverLength * axis.x, -sinOverLength * axis.y, -sinOverLength * axis.z);
    }

}
