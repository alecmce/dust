package dust.entities;

import dust.entities.impl.PooledEntities;
import dust.context.UnconfigConfig;
import dust.entities.EntitiesConfig;
import dust.app.SignalMapConfig;
import dust.context.Context;
import dust.commands.CommandMap;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.entities.api.Entities;
import dust.components.BitfieldFactory;
import dust.entities.api.Entities;

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
            entities.release(entity);
    }
}
