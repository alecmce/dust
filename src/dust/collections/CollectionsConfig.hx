package dust.collections;

import dust.collections.api.CollectionListeners;
import dust.collections.control.CollectionSubscriber;
import dust.collections.data.CollectionList;
import dust.collections.control.CollectionMap;
import dust.context.Context;
import dust.Injector;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.EntitiesConfig;

class CollectionsConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var context:Context;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig];

    public function configure()
    {
        injector.mapSingleton(CollectionList);
        injector.mapSingleton(CollectionSubscriber);
        injector.mapSingleton(CollectionMap);

        context.started.bind(onContextStarted);
    }

    function onContextStarted()
        injector.getInstance(CollectionMap).instantiateAll();
}
