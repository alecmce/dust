package dust.entities;

import dust.entities.impl.PooledEntities;
import dust.components.BitfieldFactory;
import dust.entities.api.Entities;
import dust.entities.api.Entity;
import dust.lists.SimpleList;
import dust.entities.impl.EntityList;

class SimpleEntityListTest
{
    var entities:Entities;
    var list:EntityList;

    @Before public function before()
    {
        var factory = new BitfieldFactory();
        entities = new PooledEntities(factory);
        list = new EntityList(new SimpleList<Entity>());
    }

    @Test public function afterAddingEntityHasReturnsTrue()
    {
        var entity = entities.require();
        list.add(entity);
        Assert.isTrue(list.has(entity));
    }

    @Test public function afterRemovingAddedEntityHasReturnsFalse()
    {
        var entity = entities.require();
        list.add(entity);
        list.remove(entity);
        Assert.isFalse(list.has(entity));
    }

    @Test public function afterRemovingAddedEntityItIsNotIteratedOver()
    {
        var entity = entities.require();
        list.add(entity);
        list.remove(entity);

        var isEntityIteratedOver = false;
        for (item in list)
        {
            if (item == entity)
                isEntityIteratedOver = true;
        }

        Assert.isFalse(isEntityIteratedOver);
    }
}
