package dust.systems.impl;

import dust.context.DependentConfig;
import dust.entities.Entity;
import dust.geom.data.Position;
import dust.context.Config;
import dust.context.DependentConfig;
import flash.display.Sprite;
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

class CollectionSortsTestConfig implements DependentConfig
{
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
    {
        return [SystemsConfig];
    }

    public function configure()
    {
        systems
            .map(CollectionSortsSystem, 0)
            .toCollection([Position], sorter);
    }

        function sorter(a:Entity, b:Entity):Int
            return 0;
}

class CollectionSortsSystem implements System
{
    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float) {}
}