package dust.gui;

import dust.gui.control.UISliderFactory;
import dust.gui.control.UILabelledSliderFactory;
import dust.gui.control.UILabelFactory;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.BitmapTextConfig;
import dust.gui.systems.UIViewRootManager;
import dust.collections.control.CollectionMap;
import dust.entities.EntitiesConfig;
import dust.geom.data.Position;
import dust.gui.data.UIView;
import dust.gui.systems.UpdateUISystem;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.context.DependentConfig;
import dust.context.Config;

import dust.Injector;

class GUIConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, SystemsConfig, SmallWhiteHelveticaFontConfig]

    public function configure()
    {
        injector.mapSingleton(UILabelFactory);
        injector.mapSingleton(UILabelledSliderFactory);
        injector.mapSingleton(UISliderFactory);

        collections
            .map([UIView, Position])
            .toListeners(UIViewRootManager);

        systems
            .map(UpdateUISystem)
            .toCollection([UIView, Position])
            .withName("UpdateUI");
    }
}