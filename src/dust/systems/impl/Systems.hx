package dust.systems.impl;

import dust.systems.System;

class Systems
{
    public var areRunning(default, null):Bool;

    var systemMap:SystemMap;
    var loop:SystemsLoop;

    @inject
    public function new(systemMap:SystemMap, loop:SystemsLoop)
    {
        areRunning = false;
        this.systemMap = systemMap;
        this.loop = loop;
    }

    public function setMetrics(metrics:SystemMetrics)
        systemMap.setMetrics(metrics)

    public function map(type:Class<System>):SystemMapping
        return systemMap.map(type)

    public function hasMapping(type:Class<System>):Bool
        return systemMap.hasMapping(type)

    public function unmap(type:Class<System>)
        systemMap.unmap(type)

    public function setRate(millisecondsBetweenUpdates:Int)
        loop.setRate(millisecondsBetweenUpdates)

    public function start()
    {
        areRunning = true;
        for (mapping in systemMap)
            mapping.apply(loop);

        loop.start();
    }

    public function update()
        loop.update()

    public function stop()
    {
        areRunning = false;
        loop.stop();

        for (mapping in systemMap)
            mapping.clear(loop);
    }
}
