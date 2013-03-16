package dust.systems.impl;

import dust.systems.System;
import dust.entities.impl.CollectionMap;
import dust.entities.api.Entity;
import dust.entities.api.Collection;
import dust.components.Component;

import minject.Injector;

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

    public function new(parent:Injector, collectionMap:CollectionMap, type:Class<System>)
    {
        injector = makeInjector(parent);
        this.collections = new CollectionDefinitions(injector, collectionMap);
        this.type = type;
    }

        function makeInjector(parent:Injector):Injector
        {
            var injector = new Injector();
            injector.parentInjector = parent;
            return injector;
        }

    public function isType(type:Class<System>):Bool
    {
        return this.type == type;
    }

    public function toCollection(components:Array<Class<Component>>, ?name:String = ""):SystemMapping
    {
        collections.add(components, name);
        return this;
    }

    public function withName(name:String):SystemMapping
    {
        this.name = name;
        return this;
    }

    public function withSorter(sorter:Entity->Entity->Int):SystemMapping
    {
        this.sorter = sorter;
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
