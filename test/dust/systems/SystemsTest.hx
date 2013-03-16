package dust.systems;

import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.SystemMap;
import dust.systems.impl.Systems;
import dust.systems.System;
import massive.munit.Assert;
import dust.systems.SystemsTest.TrackStartSystem;
import dust.entities.impl.CollectionMap;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;
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
            var bitfieldFactory = new BitfieldFactory();
            var collectionConnector = new CollectionConnector();
            var entities = new Entities(collectionConnector, bitfieldFactory);
            return new CollectionMap(injector, collectionConnector, bitfieldFactory, entities);
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