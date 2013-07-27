package dust.multitouch;

import dust.multitouch.systems.MouseTouchSystem;
import dust.multitouch.data.GestureAction;
import dust.multitouch.systems.DragZoomSystem;
import dust.multitouch.control.CameraDragZoomActionFactory;
import dust.multitouch.data.DragZoomGesture;
import dust.multitouch.control.DragZoomFactory;
import dust.multitouch.systems.MultiTouchSystem;
import dust.multitouch.control.Touches;
import dust.collections.control.CollectionMap;
import dust.camera.CameraConfig;
import dust.app.data.App;
import dust.math.MathConfig;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.Injector;
import dust.context.Config;
import dust.context.DependentConfig;

class MultiTouchConfig implements DependentConfig
{
    @inject public var app:App;
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [SystemsConfig, CameraConfig, MathConfig];

    public function configure()
    {
        injector.mapSingleton(Touches);
        injector.mapValue(DragZoomGesture, new DragZoomGesture().setTravel(50));
        injector.mapSingleton(CameraDragZoomActionFactory);
        injector.mapSingleton(DragZoomFactory);

        app.isMultiTouch ? mapMultiTouchSystem() : mapClickTouchSystem();

        systems
            .map(DragZoomSystem, 0)
            .toCollection([GestureAction, DragZoomGesture])
            .withName('DragZoom');
    }

        function mapMultiTouchSystem()
        {
            systems
                .map(MultiTouchSystem, 0)
                .withName('MultiTouch');
        }

        function mapClickTouchSystem()
        {
            systems
                .map(MouseTouchSystem, 0)
                .withName('MultiTouch');
        }
}
