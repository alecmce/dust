package dust.multitouch.data;

import dust.components.Component;
import dust.geom.data.Position;

class DragZoomGesture extends Component
{
    var travel:Float;
    var travelSquared:Float;

    public var isDefined(default, null):Bool;
    public var isActive(default, null):Bool;

    public var first(default, null):Touch;
    public var second(default, null):Touch;

    public var center(default, null):Position;
    public var zoomScalar(default, null):Float;

    var initialDistanceSquared:Float;

    public function new()
    {
        center = new Position();
    }

    public function setTravel(travel:Float):DragZoomGesture
    {
        this.travel = travel;
        this.travelSquared = travel * travel;
        return this;
    }

    public function init(first:Touch, second:Touch)
    {
        this.isDefined = true;
        this.isActive = false;
        this.zoomScalar = 1;

        this.first = first;
        this.second = second;

        updateCenter();
        initialDistanceSquared = squareDistance();
    }

    public function update()
    {
        if (isActive || checkActive())
            updateScalar();
    }

        inline function checkActive():Bool
        {
            var delta = first.squareDistance() + second.squareDistance();
            isActive = delta > travelSquared;
            return isActive;
        }

        inline function updateScalar()
        {
            zoomScalar = Math.sqrt(squareDistance() / initialDistanceSquared);
            updateCenter();
        }

        inline function updateCenter()
        {
            center.x = (first.current.x + second.current.x) * 0.5;
            center.y = (first.current.y + second.current.y) * 0.5;
        }

    public function clear()
    {
        isDefined = false;
        this.first = null;
        this.second = null;
    }

    inline function squareDistance():Float
    {
        var dx = second.current.x - first.current.x;
        var dy = second.current.y - first.current.y;
        return dx * dx + dy * dy;
    }
}
