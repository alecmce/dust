package dust.quadtree.data;

import dust.components.Component;
import dust.geom.data.Position;

class QuadTreeRange extends Component
{
    static var RANGE_ID:Int = 0;
    public var rangeId:Int;

    public var position:Position;
    public var extent:Float;
    public var area:Float;

    public var left(get_left, null):Float; inline function get_left() return position.x - extent;
    public var top(get_top, null):Float; inline function get_top() return position.y - extent;
    public var right(get_right, null):Float; inline function get_right() return position.x + extent;
    public var bottom(get_bottom, null):Float; inline function get_bottom() return position.y + extent;

    public function new(position:Position, extent:Float)
    {
        rangeId = ++RANGE_ID;
        set(position, extent);
    }

    inline public function set(position:Position, extent:Float)
    {
        this.position = position;
        this.extent = extent;
        this.area = extent * extent * 4;
    }

    inline public function intersects(range:QuadTreeRange):Bool
    {
        var dx = position.x - range.position.x;
        if (dx < 0) dx = -dx;

        var dy = position.y - range.position.y;
        if (dy < 0) dy = -dy;

        var de = extent + range.extent;
        return dx < de && dy < de;
    }

    inline public function contains(p:Position):Bool
    {
        var dx = p.x - position.x;
        var dy = p.y - position.y;
        return dx >= -extent && dx < extent && dy >= -extent && dy < extent;
    }

    public function subdivide():QuadTreeRanges
    {
        var x = position.x;
        var y = position.y;
        var half = extent * 0.5;

        var ranges = new QuadTreeRanges();
        ranges.tl = new QuadTreeRange(new Position(x - half, y - half), half);
        ranges.tr = new QuadTreeRange(new Position(x + half, y - half), half);
        ranges.bl = new QuadTreeRange(new Position(x - half, y + half), half);
        ranges.br = new QuadTreeRange(new Position(x + half, y + half), half);
        return ranges;
    }

    public function toString(indent:Int = 0):String
        return "[QuadTreeRange position=" + position.toString() + ", extent=" + extent + "]";
}
