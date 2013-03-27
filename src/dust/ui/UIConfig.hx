package dust.ui;

import dust.ui.components.ComponentConfig;
import dust.ui.systems.UIViewRootManager;
import dust.collections.control.CollectionMap;
import dust.entities.EntitiesConfig;
import dust.geom.data.Position;
import dust.ui.data.UIView;
import dust.ui.systems.UpdateUISystem;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.context.DependentConfig;
import dust.context.Config;

import dust.Injector;

class UIConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
    {
        return [EntitiesConfig, SystemsConfig];
    }

    public function configure()
    {
        injector.mapSingleton(ComponentConfig);

        collections
            .map([UIView, Position])
            .toListeners(UIViewRootManager);

        systems
            .map(UpdateUISystem)
            .toCollection([UIView, Position])
            .withName("UpdateUI");
    }
}