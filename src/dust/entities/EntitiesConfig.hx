package dust.entities;

import dust.context.UnconfigConfig;
import dust.entities.EntitiesConfig;
import dust.app.SignalMapConfig;
import dust.context.Context;
import dust.commands.CommandMap;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.entities.api.Entities;
import dust.entities.impl.CollectionMap;
import dust.entities.impl.CollectionConnector;
import dust.components.BitfieldFactory;
import dust.entities.api.Entities;

import minject.Injector;

class EntitiesConfig implements UnconfigConfig
{
    @inject public var injector:Injector;
    @inject public var context:Context;

    public function configure()
    {
        injector.mapSingleton(BitfieldFactory);
        injector.mapSingleton(CollectionConnector);
        injector.mapSingleton(CollectionMap);
        injector.mapSingleton(Entities);

        context.started.bind(onContextStarted);
    }

        function onContextStarted()
            injector.getInstance(CollectionMap).instantiateAll()

    public function unconfigure()
    {
        var entities:Entities = injector.getInstance(Entities);
        for (entity in entities)
            entities.release(entity);
    }
}
