package dust.systems.impl;

import dust.systems.System;
import dust.entities.impl.CollectionMap;
import dust.lists.SimpleList;

import minject.Injector;

class SystemMap
{
    var injector:Injector;
    var collectionMap:CollectionMap;
    var mappings:SimpleList<SystemMapping>;

    var metrics:SystemMetrics;

    @inject
    public function new(injector:Injector, collectionMap:CollectionMap)
    {
        this.injector = injector;
        this.collectionMap = collectionMap;
        mappings = new SimpleList<SystemMapping>();
    }

    public function setMetrics(metrics:SystemMetrics)
    {
        for (mapping in mappings)
            mapping.withMetrics(metrics);
        this.metrics = metrics;
    }

    public function map(type:Class<System>):SystemMapping
    {
        var mapping = getMapping(type);
        if (mapping == null)
            mapping = makeMapping(type);
        return mapping;
    }

    public function hasMapping(type:Class<System>):Bool
    {
        return getMapping(type) != null;
    }

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

        function makeMapping(type:Class<System>):SystemMapping
        {
            var mapping = new SystemMapping(injector, collectionMap, type);
            if (metrics != null)
                mapping.withMetrics(metrics);

            mappings.append(mapping);
            return mapping;
        }

    public function iterator():Iterator<SystemMapping>
    {
        return mappings.iterator();
    }
}
