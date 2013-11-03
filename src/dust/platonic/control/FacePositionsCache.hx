package dust.platonic.control;

import dust.math.AnglesUtil;
import dust.geom.control.RegularPolygonFactory;
import dust.graphics.data.Vertex2D;

using dust.math.AnglesUtil;

class FacePositionsCache
{
    @inject public var polygonFactory:RegularPolygonFactory;

    var angle:Float;
    var map:Map<Int, Array<Vertex2D>>;

    public function new()
    {
        angle = -90.toRadians();
        map = new Map<Int, Array<Vertex2D>>();
    }

    public function get(count:Int):Array<Vertex2D>
    {
        return if (map.exists(count))
            map.get(count);
        else
            make(count);
    }

        function make(count:Int):Array<Vertex2D>
        {
            var polygon = polygonFactory.make(count, angle);
            for (vertex in polygon)
            {
                vertex.scale(0.5);
                vertex.offset(0.5, 0.5);
            }

            map.set(count, polygon);
            return polygon;
        }
}
