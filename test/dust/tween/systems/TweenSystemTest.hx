package dust.tween.systems;

import dust.tween.data.Tween;
import dust.context.Context;
import dust.entities.Entities;
import dust.entities.Entity;
import dust.systems.impl.Systems;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.tween.TweenConfig;

import dust.Injector;
import flash.display.Sprite;

class TweenSystemTest
{
    inline static var FRICTION = 0.9;

    var entity:Entity;
    var systems:SystemsList;

    @Before public function before()
    {
        var context = new Context()
            .configure(TweenConfig)
            .start(new Sprite());

        systems = context.injector.getInstance(SystemsList);
        entity = context.injector.getInstance(Entities).require();
    }

    @Test public function pulseSystemModifiesEntityPulses()
    {
        var tween = new Tween(0, 1, 10);
        entity.add(tween);
        systems.update(1);
        Assert.areEqual(0.1, tween.value);
    }
}
