package dust.systems.impl;

#if macro

import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

#end

import dust.collections.control.CollectionMap;
import dust.components.BitfieldFactory;
import dust.entities.Entity;
import dust.systems.impl.CollectionSorts;
import dust.systems.System;
import dust.Injector;

class SystemMapping
{
    public var name:String;
    public var priority:Int;

    var injector:Injector;
    var type:Class<System>;

    var collections:CollectionDefinitions;
    var sorter:Entity->Entity->Int;
    var isApplied:Bool;
    var instance:System;

    var useTimedUpdate:Bool;
    var timedUpdateDelay:Float;

    var metrics:SystemMetrics;

    public function new(parent:Injector, collectionMap:CollectionMap, collectionSorts:CollectionSorts, type:Class<System>, priority:Int)
    {
        injector = new Injector(parent);
        this.collections = new CollectionDefinitions(injector, collectionMap, collectionSorts);
        this.type = type;
        this.priority = priority;
    }

    public function isType(type:Class<System>):Bool
    {
        return this.type == type;
    }

    macro public function toCollection(self:ExprOf<SystemMapping>, collection:Expr, ?sorter:ExprOf<Entity->Entity->Int>, ?name:ExprOf<String>):Expr
    {
        var ids = macro dust.type.TypeIndex.getClassIDList($collection, '${self.pos}');
        return macro (untyped $self.defineCollection)($ids, $sorter, $name);
    }

        function defineCollection(components:Array<Int>, sorter:Entity->Entity->Int, name:String):SystemMapping
        {
            var factory:BitfieldFactory = injector.getInstance(BitfieldFactory);
            var bitfield = factory.makeDefined(components);
            collections.add(bitfield, sorter, name);
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

    public function withTimedUpdate(seconds:Float):SystemMapping
    {
        useTimedUpdate = true;
        timedUpdateDelay = seconds;
        return this;
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
