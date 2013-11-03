package dust.geom.control;

import dust.math.trig.Trig;
import dust.math.AnglesUtil;
import dust.graphics.data.Vertex2D;

class RegularPolygonFactory
{
    @inject public var trig:Trig;

    var degrees36:Float;
    var degrees18:Float;

    public function new()
    {
        degrees36 = AnglesUtil.TO_RADIANS * 36;
        degrees18 = AnglesUtil.TO_RADIANS * 18;
    }

    public function make(count:Int, angle:Float):Array<Vertex2D>
    {
        var theta = AnglesUtil.TWO_PI / count;
        var list = new Array<Vertex2D>();
        for (i in 0...5)
        {
            trig.setAngle(angle);
            var x = trig.getCosine();
            var y = trig.getSine();
            var vertex = new Vertex2D(x, y);
            angle += theta;
            list.push(vertex);
        }
        return list;
    }
}
