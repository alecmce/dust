package dust.stats;

class RollingMean
{
    var values:Array<Float>;
    var count:Int;
    var index:Int;
    var sum:Float;

    var valuesToCount:Int;
    var maxIndex:Int;

    public function new(valuesToCount:Int)
    {
        this.valuesToCount = valuesToCount;

        values = [];
        count = 0;
        sum = 0;
        index = 0;
    }

    public function update(value:Float)
    {
        sum += value;
        if (isEstablished())
            updateEstablished(value);
        else
            values[count++] = value;
    }

    inline function isEstablished():Bool
    return count == valuesToCount;

    inline function updateEstablished(value:Float)
    {
        sum -= values[index];
        values[index++] = value;
        if (index == count)
            index = 0;
    }

    public function getMean():Float
    return sum / count;
}
