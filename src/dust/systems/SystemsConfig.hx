package dust.systems;

import dust.systems.systems.SortCollectionsSystem;
import dust.systems.impl.CollectionSorts;
import dust.systems.systems.UpdateCollectionsSystem;
import dust.collections.CollectionsConfig;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.SystemMap;
import dust.systems.impl.Systems;
import dust.systems.control.StopSystemsSignal;
import dust.systems.control.StartSystemsSignal;
import dust.systems.impl.Systems;
import dust.context.Context;
import dust.signals.SignalMapConfig;
import dust.signals.SignalMap;
import dust.signals.SignalVoid;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.systems.impl.Systems;
import dust.collections.control.CollectionMap;

import dust.Injector;

class SystemsConfig implements DependentConfig
{
    inline static var MAX_INT = 0x3FFFFFFF;

    @inject public var context:Context;
    @inject public var injector:Injector;
    @inject public var signals:SignalMap;
    @inject public var collections:CollectionMap;

    public function dependencies():Array<Class<Config>>
        return [SignalMapConfig, CollectionsConfig];

    public function configure()
    {
        injector.mapSingleton(CollectionSorts);
        injector.mapSingleton(SystemMap);
        injector.mapSingleton(SystemsLoop);
        injector.mapSingleton(SystemsList);
        injector.mapSingleton(Systems);
        injector.mapSingleton(UpdateCollectionsSystem);

        configureSystems(injector.getInstance(Systems));
    }

        function configureSystems(systems:Systems)
        {
            systems
                .map(UpdateCollectionsSystem, MAX_INT)
                .withName("Update Collections");

            systems
                .map(SortCollectionsSystem, MAX_INT - 1)
                .withName("Sort Collections");

            signals.mapVoid(StartSystemsSignal, systems.start);
            signals.mapVoid(StopSystemsSignal, systems.stop);

            context.started.bind(systems.start);
            context.started.bind(collections.instantiateAll);
            context.stopped.bind(systems.stop);
        }
}