package dust.math.trig;

import dust.geom.data.Delta;

interface Trig
{
    function setAngle(angle:Float):Void;
    function getAngle():Float;
    function getSine():Float;
    function getCosine():Float;

    function setDirection(dx:Float, dy:Float):Void;
}
