package dust.relations;

import dust.relations.control.RelationHash;
import dust.relations.control.Relations;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.entities.EntitiesConfig;
import dust.app.data.App;
import dust.context.Config;
import dust.context.DependentConfig;

class RelationsConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, SystemsConfig];

    public function configure()
    {
        injector.mapSingleton(RelationHash);
        injector.mapSingleton(Relations);
    }
}
