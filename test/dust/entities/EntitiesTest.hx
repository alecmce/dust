package dust.entities;

import dust.components.BitfieldFactory;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionConnector;
import massive.munit.Assert;

class EntitiesTest
{
    var connector:CollectionConnector;
    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;

    @Before public function before()
    {
        bitfieldFactory = new BitfieldFactory();
        connector = new CollectionConnector();
        entities = new Entities(connector, bitfieldFactory);
    }

    @Test public function canRequireEntity()
    {
        Assert.isType(entities.require(), Entity);
    }

    @Test public function canPopulatePoolOfEntities()
    {
        entities.populate(10);
    }

    @Test public function releasedEntitiesArePooledForReuse()
    {
        var first = entities.require();
        first.dispose();
        var second = entities.require();
        Assert.areSame(first, second);
    }

    @Test public function aRequiredEntityIsIteratedOver()
    {
        var required = entities.require();
        var isMatch = false;
        for (entity in entities)
            isMatch = isMatch || entity == required;

        Assert.isTrue(isMatch);
    }
}
