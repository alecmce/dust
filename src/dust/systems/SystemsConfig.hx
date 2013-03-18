package dust.systems;

import dust.systems.systems.UpdateCollectionsSystem;
import dust.collections.CollectionsConfig;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemsLoop;
import dust.systems.impl.SystemMap;
import dust.systems.impl.Systems;
import dust.systems.control.StopSystemsSignal;
import dust.systems.control.StartSystemsSignal;
import dust.app.CommandMapConfig;
import dust.commands.CommandMap;
import dust.systems.impl.Systems;
import dust.context.Context;
import dust.app.SignalMapConfig;
import dust.entities.EntitiesConfig;
import dust.signals.SignalMap;
import dust.signals.SignalVoid;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.systems.impl.Systems;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entities;
import dust.components.BitfieldFactory;

import minject.Injector;

class SystemsConfig implements DependentConfig
{
    @inject public var context:Context;
    @inject public var injector:Injector;
    @inject public var signalMap:SignalMap;

    public function dependencies():Array<Class<Config>>
        return [SignalMapConfig, CollectionsConfig]

    public function configure()
    {
        injector.mapSingleton(SystemMap);
        injector.mapSingleton(SystemsLoop);
        injector.mapSingleton(SystemsList);
        injector.mapSingleton(Systems);
        injector.mapSingleton(UpdateCollectionsSystem);

        var loop:SystemsLoop = injector.getInstance(SystemsLoop);
        loop.add(injector.getInstance(UpdateCollectionsSystem));

        var systems:Systems = injector.getInstance(Systems);
        signalMap.mapVoid(StartSystemsSignal, systems.start);
        signalMap.mapVoid(StopSystemsSignal, systems.stop);

        context.started.bind(onStarted);
        context.stopped.bind(onStopped);
    }

        function onStarted()
            injector.getInstance(Systems).start()

        function onStopped()
            injector.getInstance(Systems).stop()
}