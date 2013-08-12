package dust.systems.impl;

import dust.entities.Entities;
import dust.collections.data.CollectionList;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.SystemMap;
import dust.systems.impl.Systems;
import dust.systems.System;
import dust.collections.control.CollectionMap;
import dust.entities.Entities;
import dust.bitfield.BitfieldFactory;
import dust.Injector;

class SystemsTest
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var collectionSorts:CollectionSorts;
    var systems:Systems;

    @Before public function before()
    {
        TrackStartSystem.isStarted = false;

        injector = new Injector();
        collectionMap = makeCollectionMap();
        collectionSorts = new CollectionSorts();
        var systemMap = new SystemMap(injector, collectionMap, collectionSorts);
        var list = new SystemsList();
        var loop = new SystemsLoop(list);
        systems = new Systems(systemMap, loop);
    }

        function makeCollectionMap():CollectionMap
        {
            var map = new CollectionMap();
            map.injector = injector;
            map.bitfieldFactory = new BitfieldFactory();
            map.entities = new Entities(map.bitfieldFactory);
            map.collectionList = new CollectionList();
            return map;
        }

    @Test public function mappedSystemsStartOnSystemsStart()
    {
        systems.map(TrackStartSystem, 0);
        systems.start();

        Assert.isTrue(TrackStartSystem.isStarted);
    }

    @Test public function systemMappedAfterSystemsStartedIsStartedNextIteration()
    {
        systems.start();
        systems.map(TrackStartSystem, 0);
        systems.update();

        Assert.isTrue(TrackStartSystem.isStarted);
    }
}

class TrackStartSystem implements System
{
    public static var isStarted:Bool;

    public function new()
    {
        isStarted = false;
    }

    public function start()
    {
        isStarted = true;
    }

    public function stop() {}
    public function iterate(deltaTime:Float) {}
}