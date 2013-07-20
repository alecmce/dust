package dust.entities;

import dust.entities.Entity;
import dust.entities.Entities;
import dust.lists.PooledList;
import dust.lists.Pool;
import dust.bitfield.BitfieldFactory;

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

        function makeEntity():Entity
            return new Entity(++id, bitfieldFactory.makeEmpty());

    public function require():Entity
    {
        var entity = pool.require();
        list.append(entity);
        return entity;
    }

    public function release(entity:Entity)
    {
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