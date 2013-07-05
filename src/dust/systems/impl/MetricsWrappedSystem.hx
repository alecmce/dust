package dust.systems.impl;

import haxe.Timer;
import dust.systems.System;

class MetricsWrappedSystem implements System
{
    var metrics:SystemMetrics;
    var label:String;
    var system:System;

    public function new(metrics:SystemMetrics, label:String, system:System)
    {
        this.metrics = metrics;
        this.label = label;
        this.system = system;

        if (label == null)
            label = Type.getClassName(Type.getClass(system));
    }

    public function start()
        system.start();

    public function stop()
        system.stop();

    public function iterate(deltaTime:Float)
    {
        var time = Timer.stamp();
        system.iterate(deltaTime);
        metrics.recordTime(label, Timer.stamp() - time);
    }
}
