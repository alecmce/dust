package dust.systems.impl;

import dust.systems.impl.CollectionSorts;
import dust.systems.System;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entity;
import dust.collections.api.Collection;
import dust.components.Component;

import dust.Injector;

class SystemMapping
{
    var injector:Injector;
    var type:Class<System>;

    var collections:CollectionDefinitions;
    var sorter:Entity->Entity->Int;
    var isApplied:Bool;
    var instance:System;

    var useTimedUpdate:Bool;
    var timedUpdateDelay:Float;

    var name:String;
    var metrics:SystemMetrics;

    public function new(parent:Injector, collectionMap:CollectionMap, collectionSorts:CollectionSorts, type:Class<System>)
    {
        injector = new Injector(parent);
        this.collections = new CollectionDefinitions(injector, collectionMap, collectionSorts);
        this.type = type;
    }

    public function isType(type:Class<System>):Bool
    {
        return this.type == type;
    }

    public function toCollection(components:Array<Class<Component>>, ?sorter:Entity->Entity->Int = null, ?name:String = ""):SystemMapping
    {
        collections.add(components, sorter, name);
        return this;
    }

    public function withName(name:String):SystemMapping
    {
        this.name = name;
        return this;
    }

    public function withMetrics(metrics:SystemMetrics):SystemMapping
    {
        this.metrics = metrics;
        return this;
    }

    public function withTimedUpdate(seconds:Float)
    {
        useTimedUpdate = true;
        timedUpdateDelay = seconds;
    }

    public function apply(loop:SystemsLoop)
    {
        if (!isApplied)
        {
            isApplied = true;
            applyInstance(loop);
        }
    }

    public function getInstance():System
    {
        if (instance == null)
            instance = makeInstance();
        return instance;
    }

        function applyInstance(loop:SystemsLoop)
        {
            getInstance();
            if (instance == null)
                throw new UnableToInstantiateType();
            loop.add(instance);
        }

        function makeInstance():System
        {
            collections.map();
            var value = injector.instantiate(type);
            collections.unmap();
            return getSystemWrapper(value);
        }

            function getSystemWrapper(value:System):System
            {
                if (useTimedUpdate)
                    value = new TimedSystem(timedUpdateDelay, value);

                if (metrics != null)
                    value = new MetricsWrappedSystem(metrics, name, value);

                return value;
            }

    public function clear(loop:SystemsLoop)
    {
        if (isApplied)
        {
            isApplied = false;
            clearInstance(loop);
        }
    }

        function clearInstance(loop:SystemsLoop)
        {
            loop.remove(instance);
            instance = null;
        }
}

class UnableToInstantiateType
{
    public function new() {}
}
