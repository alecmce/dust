package dust.entities;

import dust.components.MockComponentA;
import dust.components.BitfieldFactory;
import dust.entities.Entity;
import dust.entities.Entities;

class EntitiesTest
{
    var bitfieldFactory:BitfieldFactory;
    var entities:Entities;

    @Before public function before()
    {
        bitfieldFactory = new BitfieldFactory();
        entities = new Entities(bitfieldFactory);
    }

    @Test public function canRequireEntity()
    {
        Assert.isType(entities.require(), Entity);
    }

    @Test public function releasedEntitiesArePooledForReuse()
    {
        var first = entities.require();
        entities.release(first);
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
