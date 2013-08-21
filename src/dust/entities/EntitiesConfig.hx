package dust.entities;

import dust.bitfield.BitfieldFactory;
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
