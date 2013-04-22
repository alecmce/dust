package dust.multitouch.data;

import dust.components.Component;
import dust.geom.data.Position;

class Touch extends Component
{
    public static function make():Touch
        return new Touch()

    public var id:Int;

    public var start:Position;
    public var startTime:Float;

    public var current:Position;
    public var currentTime:Float;

    public var sizeX:Float;
    public var sizeY:Float;
    public var pressure:Float;

    public var isCurrent:Bool;

    public function new()
    {
        start = new Position();
        current = new Position();
    }

    public function init(id:Int, x:Float, y:Float, time:Float):Touch
    {
        this.id = id;
        this.start.set(x, y);
        this.startTime = time;

        this.current.set(x, y);
        this.currentTime = time;

        this.isCurrent = true;

        return this;
    }

    public function setSize(sizeX:Float, sizeY:Float, pressure:Float):Touch
    {
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this.pressure = pressure;
        return this;
    }

    public function update(x:Float, y:Float, time:Float):Touch
    {
        this.current.set(x, y);
        this.currentTime = time;
        return this;
    }

    public function clear()
    {
        this.isCurrent = false;
    }

    inline public function squareDistance():Float
    {
        var dx = current.x - start.x;
        var dy = current.y - start.y;
        return dx * dx + dy * dy;
    }

    public function toString():String
        return ['[Touch id=',id,' x=',current.x,' y=',current.y,']'].join('')

}
