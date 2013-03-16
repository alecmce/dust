package dust.tween.systems;

import dust.tween.data.Tween;
import dust.context.Context;
import dust.entities.api.Entities;
import dust.entities.api.Entity;
import dust.systems.impl.Systems;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.tween.TweenConfig;

import minject.Injector;
import nme.display.Sprite;

class TweenSystemTest
{
    inline static var FRICTION = 0.9;

    var entity:Entity;
    var systems:SystemsList;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(TweenConfig)
            .start(new Sprite());

        systems = injector.getInstance(SystemsList);
        entity = injector.getInstance(Entities).require();
    }

    @Test public function pulseSystemModifiesEntityPulses()
    {
        var tween = new Tween(0, 1, 10);
        entity.add(tween);
        systems.update(1);
        Assert.areEqual(0.1, tween.value);
    }
}
