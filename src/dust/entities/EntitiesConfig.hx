package dust.entities;

import dust.signals.SignalMapConfig;
import dust.commands.CommandMap;
import dust.components.BitfieldFactory;
import dust.context.Config;
import dust.context.Context;
import dust.context.DependentConfig;
import dust.context.UnconfigConfig;
import dust.entities.api.Entities;
import dust.entities.EntitiesConfig;
import dust.entities.impl.PooledEntities;

import minject.Injector;

class EntitiesConfig implements UnconfigConfig
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(BitfieldFactory);
        injector.mapSingletonOf(Entities, PooledEntities);
    }

    public function unconfigure()
    {
        var entities:Entities = injector.getInstance(Entities);
        for (entity in entities)
            entity.dispose();
    }
}
