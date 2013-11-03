package dust.inspector.data;

import dust.entities.Entities;
import dust.entities.EntitiesConfig;
import flash.display.Sprite;
import dust.context.Context;
import dust.geom.data.Position;

class InspectorTest
{
    var context:Context;
    var injector:Injector;
    var entities:Entities;
    var inspector:Inspector;

    @Before public function before()
    {
        context = new Context()
            .configure(EntitiesConfig)
            .start(new Sprite());
        injector = context.injector;
        entities = injector.getInstance(Entities);

        inspector = new Inspector();
    }

    @Test public function hasReturnsFalseUnlessValueIsAdded()
    {
        Assert.isFalse(inspector.has(Position, 'x'));
    }

    @Test public function canAddInspectedValue()
    {
        inspector.add(Position, 'x');
        Assert.isTrue(inspector.has(Position, 'x'));
    }

    @Test public function updatesFromEntity()
    {
        var entity = entities.require();
        entity.add(new Position(3, 4));

        inspector.add(Position, 'x');
        inspector.update(entity);

        for (field in inspector)
            Assert.areEqual(3, field.value);
    }
}