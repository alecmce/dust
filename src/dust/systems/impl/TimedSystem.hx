package dust.systems.impl;

import dust.systems.System;

class TimedSystem implements System
{
    public var delay:Float;
    public var system:System;

    var cumulativeTime:Float;

    public function new(delay:Float, system:System)
    {
        this.delay = delay;
        this.system = system;

        cumulativeTime = 0;
    }

    public function start()
    {
        cumulativeTime = delay;
        system.start();
    }

    public function stop()
    {
        system.stop();
    }

    public function iterate(deltaTime:Float)
    {
        cumulativeTime += deltaTime;
        if (cumulativeTime >= delay)
            updateAndResetCumulativeTime();
    }

        inline function updateAndResetCumulativeTime()
        {
            system.iterate(cumulativeTime);
            cumulativeTime = 0;
        }
}
