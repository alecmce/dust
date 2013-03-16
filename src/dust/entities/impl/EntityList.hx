package dust.entities.impl;

import dust.entities.api.Entity;

interface EntityList
{
    function has(entity:Entity):Bool;

    function add(entity:Entity):Void;

    function remove(entity:Entity):Void;

    function iterator():Iterator<Entity>;
}
