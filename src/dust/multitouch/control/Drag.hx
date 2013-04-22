package dust.multitouch.control;

class Drag
{
    var delta:Array<{dx:Float, dy:Float, ds:Float}>;
    var memory:Int;
    var index:Int;
    var count:Int;

    public function new(?memory:Int = 5)
    {
        this.memory = memory;
        this.index = 0;
        this.count = 0;
        this.delta = makeDelta();
    }

    function makeDelta():Array<{dx:Float, dy:Float, ds:Float}>
    {
        var list = new Array<Float>();
        for (i in 0...memory)
            delta.push({dx:0.0, dy:0.0, ds:0.0})
        return list;
    }

    public function addDrag(dx:Float, dy:Float, ds):Void
    {
        var vo = delta[index];
        vo.dx = dx;
        vo.dy = dy;
        vo.ds = ds;

        if (count < memory)
            ++count;

        if (++index == memory)
            index = 0;
    }

    public function getVelocity():{dx:Float, dy:Float, ds:Float}
    {
        var output = {dx:0.0, dy:0.0, ds:0.0};

        for (i in 0...count)
        {
            var vo = delta[i];
            output.dx += vo.dx;
            output.dy += vo.dy;
            output.ds += vo.ds;
        }

        if (count > 0)
        {
            output.dx /= count;
            output.dy /= count;
            output.ds /= count;
        }

        return output;
    }

    public function clear():Void
    {
        count = 0;
        index = 0;
    }
}
