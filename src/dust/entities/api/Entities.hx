package dust.entities.api;

interface Entities
{
    function require():Entity;
    function release(entity:Entity):Void;
    function iterator():Iterator<Entity>;
}