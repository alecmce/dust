package dust.systems.impl;

import dust.entities.api.Entity;
import dust.geom.data.Position;
import dust.context.Config;
import dust.context.DependentConfig;
import nme.display.Sprite;
import dust.context.Context;

class CollectionSortsTest
{
    @Test public function configuringASystemWithASortedCollectionAddsSortToCollectionSorts()
    {
        var context = new Context()
            .configure(SystemsConfig)
            .configure(CollectionSortsTestConfig)
            .start(new Sprite());

        var sorts:CollectionSorts = context.injector.getInstance(CollectionSorts);
        Assert.listCountEquals(sorts.iterator(), 1);
    }
}

class CollectionSortsTestConfig implements Config
{
    @inject public var systems:Systems;

    public function configure()
    {
        systems
            .map(CollectionSortsSystem)
            .toCollection([Position], sorter);
    }

        function sorter(a:Entity, b:Entity):Int
            return 0
}

class CollectionSortsSystem implements System
{
    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float) {}
}