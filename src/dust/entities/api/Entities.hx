package dust.entities.api;

import dust.lists.PooledList;
import dust.lists.Pool;
import dust.components.BitfieldFactory;
import dust.entities.impl.CollectionConnector;

class Entities
{
    public static function make():Entities
    {
        var collectionConnector = new CollectionConnector();
        var bitfieldFactory = new BitfieldFactory();
        return new Entities(collectionConnector, bitfieldFactory);
    }

    var collectionConnector:CollectionConnector;
    var bitfieldFactory:BitfieldFactory;
    var pool:Pool<Entity>;
    var list:PooledList<Entity>;

    @inject
    public function new(collectionConnector:CollectionConnector, bitfieldFactory:BitfieldFactory)
    {
        this.collectionConnector = collectionConnector;
        this.bitfieldFactory = bitfieldFactory;
        pool = new Pool<Entity>(makeEntity);
        list = new PooledList<Entity>();
    }

        inline function makeEntity():Entity
        {
            var bitfield = bitfieldFactory.makeEmpty();
            return new Entity(this, bitfield, collectionConnector);
        }

    public function require():Entity
    {
        var entity = pool.require();
        list.append(entity);
        return entity;
    }

    public function release(entity:Entity)
    {
        entity.removeAll();
        pool.release(entity);
        list.remove(entity);
    }

    public function populate(count:Int)
    {
        pool.populate(count);
        list.populate(count);
    }

    public function iterator():Iterator<Entity>
    {
        return list.iterator();
    }
}