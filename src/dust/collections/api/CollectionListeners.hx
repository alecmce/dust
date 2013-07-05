package dust.collections.api;

import dust.entities.Entity;

interface CollectionListeners
{
    function onEntityAdded(entity:Entity):Void;
    function onEntityRemoved(entity:Entity):Void;
}
