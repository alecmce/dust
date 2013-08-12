package dust.systems.impl;

#if !macro

import dust.lists.SimpleList;
import dust.lists.LinkedList;
import dust.lists.LinkedList;
import dust.systems.System;

import haxe.Timer;

#end

class SystemsLoop
{
    inline static var DEFAULT_MILLISECONDS_BETWEEN_UPDATES = 16;

    var systems:SystemsList;
    var millisecondsBetweenUpdates:Int;
    var isStarted:Bool;

    #if !macro
    var timer:haxe.Timer;
    #end

    var time:Float;
    var pendingSystems:PendingSystems;

    @inject public function new(systems:SystemsList)
    {
        this.systems = systems;
        millisecondsBetweenUpdates = DEFAULT_MILLISECONDS_BETWEEN_UPDATES;
        isStarted = false;

        pendingSystems = new PendingSystems(this);
    }

    public function setRate(millisecondsBetweenUpdates:Int)
    {
        this.millisecondsBetweenUpdates = millisecondsBetweenUpdates;
    }

    public function add(system:System)
    {
        systems.add(system);
    }

    public function remove(system:System)
    {
        systems.remove(system);
    }

    public function addPending(mapping:SystemMapping)
    {
        pendingSystems.add(mapping);
    }

    public function start()
    {
        if (!isStarted)
        {
            systems.start();
            #if !macro
            makeTimer();
            #end
        }
    }

        function makeTimer()
        {
            #if !macro
            isStarted = true;
            timer = new haxe.Timer(millisecondsBetweenUpdates);
            timer.run = update;
            time = haxe.Timer.stamp();
            #end
        }

    public function update()
    {
        #if !macro
        var newTime = Timer.stamp();
        var deltaTime = newTime - time;
        time = newTime;
        systems.update(deltaTime);
        pendingSystems.update();
        #end
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
            #if !macro
            timer.stop();
            timer = null;
            #end
        }
}