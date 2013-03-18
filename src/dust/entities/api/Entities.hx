package dust.entities.api;

import dust.lists.PooledList;
import dust.lists.Pool;
import dust.components.BitfieldFactory;

class Entities
{
    var bitfieldFactory:BitfieldFactory;

    var id:Int;
    var pool:Pool<Entity>;
    var list:PooledList<Entity>;

    @inject
    public function new(bitfieldFactory:BitfieldFactory)
    {
        this.bitfieldFactory = bitfieldFactory;

        id = 0;
        pool = new Pool<Entity>(makeEntity);
        list = new PooledList<Entity>();
    }

        inline function makeEntity():Entity
        {
            var bitfield = bitfieldFactory.makeEmpty();
            return new Entity(++id, bitfield);
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