package dust.systems.impl;

import dust.stats.RollingMean;

class SystemMetricsData
{
    public var label:String;

    var rollingMean:RollingMean;
    var total:Float;

    public function new(label:String, valuesToCount:Int)
    {
        this.label = label;
        this.rollingMean = new RollingMean(valuesToCount);
        this.total = 0;
    }

    public function add(value:Float)
        total += value;

    public function update()
    {
        rollingMean.update(total);
        total = 0;
    }

    public function getMean():Float
        return rollingMean.getMean();
}
