package dust.systems.impl;

import dust.systems.System;

class MockSystem implements System
{
    public var isStarted:Bool;
    public var isStopped:Bool;
    public var isIterated:Bool;
    public var lastDeltaTime:Float;

    public function new()
    {
        isStarted = false;
        isStopped = false;
        isIterated = false;
        lastDeltaTime = -1;
    }

    public function start()
    {
        isStarted = true;
    }

    public function stop()
    {
        isStopped = true;
    }

    public function iterate(deltaTime:Float)
    {
        isIterated = true;
        lastDeltaTime = deltaTime;
    }

}
