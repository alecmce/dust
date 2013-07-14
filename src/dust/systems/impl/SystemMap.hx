package dust.systems.impl;

import dust.lists.SortedList;
import dust.systems.System;
import dust.collections.control.CollectionMap;
import dust.lists.SimpleList;

import dust.Injector;

class SystemMap
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var collectionSorts:CollectionSorts;
    var mappings:SortedList<SystemMapping>;

    var metrics:SystemMetrics;

    @inject public function new(injector:Injector, collectionMap:CollectionMap, collectionSorts:CollectionSorts)
    {
        this.injector = injector;
        this.collectionMap = collectionMap;
        this.collectionSorts = collectionSorts;
        mappings = new SortedList(new SimpleList<SystemMapping>(), prioritySort);
    }

        function prioritySort(a:SystemMapping, b:SystemMapping):Int
            return b.priority - a.priority;

    public function setMetrics(metrics:SystemMetrics)
    {
        for (mapping in mappings)
            mapping.withMetrics(metrics);
        this.metrics = metrics;
    }

    public function map(type:Class<System>, priority:Int):SystemMapping
    {
        var mapping = getMapping(type);
        if (mapping == null)
            mapping = makeMapping(type, priority);
        return mapping;
    }

    public function hasMapping(type:Class<System>):Bool
        return getMapping(type) != null;

    public function unmap(type:Class<System>)
    {
        var mapping = getMapping(type);
        if (mapping != null)
            mappings.remove(mapping);
    }

        function getMapping(type:Class<System>):SystemMapping
        {
            for (mapping in mappings)
                if (mapping.isType(type))
                    return mapping;
            return null;
        }

        function makeMapping(type:Class<System>, priority:Int):SystemMapping
        {
            var mapping = new SystemMapping(injector, collectionMap, collectionSorts, type, priority);
            if (metrics != null)
                mapping.withMetrics(metrics);

            mappings.add(mapping);
            return mapping;
        }

    public function iterator():Iterator<SystemMapping>
        return mappings.iterator();
}
