package dust.gui;

import dust.camera.CameraConfig;
import dust.camera.data.Camera;
import dust.camera.control.CameraFactory;
import dust.gui.control.UISliderFactory;
import dust.gui.control.UILabelledSliderFactory;
import dust.gui.control.UILabelFactory;
import dust.text.SmallWhiteHelveticaFontConfig;
import dust.text.BitmapTextConfig;
import dust.gui.systems.UIRootManager;
import dust.collections.control.CollectionMap;
import dust.entities.EntitiesConfig;
import dust.geom.data.Position;
import dust.gui.data.UIContainer;
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
    @inject public var cameraFactory:CameraFactory;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, SystemsConfig, CameraConfig, SmallWhiteHelveticaFontConfig];

    public function configure()
    {
        injector.mapSingleton(UILabelFactory);
        injector.mapSingleton(UILabelledSliderFactory);
        injector.mapSingleton(UISliderFactory);
        injector.mapValue(Camera, cameraFactory.make(), 'ui');

        collections
            .map([UIContainer, Position])
            .toListeners(UIRootManager);

        systems
            .map(UpdateUISystem)
            .toCollection([UIContainer, Position])
            .withName("UpdateUI");
    }
}