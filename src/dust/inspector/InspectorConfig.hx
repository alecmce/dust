package dust.inspector;

import dust.inspector.control.UIInspectorFactory;
import dust.inspector.control.UIInspectedFieldFactory;
import dust.gui.GUIConfig;
import dust.entities.EntitiesConfig;
import dust.inspector.systems.InspectorListeners;
import dust.collections.control.CollectionMap;
import dust.inspector.data.Inspector;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.context.Config;
import dust.context.DependentConfig;

class InspectorConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, SystemsConfig, GUIConfig]

    public function configure()
    {
        injector.mapSingleton(UIInspectedFieldFactory);
        injector.mapSingleton(UIInspectorFactory);

        collections
            .map([Inspector])
            .toListeners(InspectorListeners);
    }
}
