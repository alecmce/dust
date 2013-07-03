package dust.systems.impl;

import dust.systems.System;
import dust.type.TypeIndex;
import dust.stats.RollingMean;

class SystemMetrics
{
    var valuesToCount:Int;
    var hash:Map<String, SystemMetricsData>;

    public function new(valuesToCount:Int)
    {
        this.valuesToCount = valuesToCount;
        this.hash = new Hash<SystemMetricsData>();
    }

    public function recordTime(label:String, value:Float)
    {
        if (label != null)
            getData(label).add(value);
    }

    public function getMean(label:String):Float
        return getData(label).getMean();

        function getData(label:String):SystemMetricsData
            return hash.exists(label) ? hash.get(label) : makeData(label);

            function makeData(label:String):SystemMetricsData
            {
                var data = new SystemMetricsData(label, valuesToCount);
                hash.set(label, data);
                return data;
            }

    public function update()
    {
        for (metrics in hash)
            metrics.update();
    }

    public function iterator():Iterator<SystemMetricsData>
        return hash.iterator();
}
