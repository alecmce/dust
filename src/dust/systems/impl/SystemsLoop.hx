package dust.systems.impl;

import dust.lists.SimpleList;
import dust.lists.LinkedList;
import dust.lists.LinkedList;
import dust.systems.System;

import haxe.Timer;

class SystemsLoop
{
    inline static var DEFAULT_MILLISECONDS_BETWEEN_UPDATES = 16;

    var systems:SystemsList;
    var millisecondsBetweenUpdates:Int;
    var isStarted:Bool;
    var timer:Timer;
    var time:Float;

    @inject
    public function new(systems:SystemsList)
    {
        this.systems = systems;
        millisecondsBetweenUpdates = DEFAULT_MILLISECONDS_BETWEEN_UPDATES;
        isStarted = false;
    }

    public function setRate(millisecondsBetweenUpdates:Int)
    {
        this.millisecondsBetweenUpdates = millisecondsBetweenUpdates;
    }

    public function add(system:System)
        systems.add(system)

    public function remove(system:System)
        systems.remove(system)

    public function start()
    {
        if (!isStarted)
        {
            systems.start();
            makeTimer();
        }
    }

        function makeTimer()
        {
            isStarted = true;
            timer = new Timer(millisecondsBetweenUpdates);
            timer.run = update;
            time = Timer.stamp();
        }

    public function update()
    {
        var newTime = Timer.stamp();
        var deltaTime = newTime - time;
        time = newTime;
        systems.update(deltaTime);
    }

    public function stop()
    {
        if (isStarted)
        {
            stopTimer();
            time = -1;
            systems.stop();
        }
    }

        function stopTimer()
        {
            isStarted = false;
            timer.stop();
            timer = null;
        }
}