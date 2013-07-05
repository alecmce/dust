package dust.entities;

import dust.signals.SignalMapConfig;
import dust.commands.CommandMap;
import dust.components.BitfieldFactory;
import dust.context.Config;
import dust.context.Context;
import dust.context.DependentConfig;
import dust.context.UnconfigConfig;
import dust.entities.Entities;

import dust.Injector;

class EntitiesConfig implements UnconfigConfig
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(BitfieldFactory);
        injector.mapSingleton(Entities);
    }

    public function unconfigure()
    {
        var entities:Entities = injector.getInstance(Entities);
        for (entity in entities)
            entity.dispose();
    }
}
