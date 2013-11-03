package dust.inspector.control;

import dust.inspector.data.Inspector;
import dust.geom.data.Position;
import dust.entities.EntitiesConfig;
import dust.context.Context;
import dust.entities.Entities;

import flash.display.Sprite;

class InspectorPopulatorTest
{
    var populator:InspectorPopulator;
    var entities:Entities;

    @Before public function before()
    {
        populator = new InspectorPopulator();

        var context = new Context()
            .configure(EntitiesConfig)
            .start(new Sprite());
        entities = context.injector.getInstance(Entities);
    }

    @Test public function populatesWithXFieldOfPositionComponent()
    {
        trace('populatesWithXFieldOfPositionComponent...');
        var entity = entities.require();
        entity.add(new Position(3, 5));

        var inspector = new Inspector();
        populator.populate(entity, inspector);

        var isFound:Bool = false;
        for (field in inspector)
        {
            trace('field: ${field.id},${field.type},${field.field}');
            isFound = isFound || field.type == dust.type.TypeIndex.getClassID(Position, '') && field.field == "x";
        }
        trace('...populatesWithXFieldOfPositionComponent');

        Assert.isTrue(isFound);
    }
}