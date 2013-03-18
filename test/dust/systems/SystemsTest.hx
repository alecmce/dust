package dust.systems;

import dust.collections.data.CollectionList;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.SystemMap;
import dust.systems.impl.Systems;
import dust.systems.System;
import dust.systems.SystemsTest.TrackStartSystem;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entities;
import dust.components.BitfieldFactory;
import minject.Injector;

class SystemsTest
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var systems:Systems;

    @Before public function before()
    {
        injector = new Injector();
        collectionMap = makeCollectionMap();
        var systemMap = new SystemMap(injector, collectionMap);
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
        systems.map(TrackStartSystem);
        systems.start();

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