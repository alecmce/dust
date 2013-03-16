package dust.systems.impl;

import dust.lists.SimpleList;

class SystemsList
{
    var isStarted:Bool;
    var list:SimpleList<System>;

    public function new()
    {
        isStarted = false;
        list = new SimpleList<System>();
    }

    public function add(system:System)
    {
        list.append(system);
        if (isStarted)
            system.start();
    }

    public function remove(system:System)
    {
        list.remove(system);
        if (isStarted)
            system.stop();
    }

    public function start()
    {
        isStarted = true;
        for (system in list)
            system.start();
    }

    public function update(deltaTime:Float)
    {
        for (system in list)
            system.iterate(deltaTime);
    }

    public function stop()
    {
        isStarted = false;
        for (system in list)
            system.stop();
    }

    public function iterator():Iterator<System>
        return list.iterator()
}
