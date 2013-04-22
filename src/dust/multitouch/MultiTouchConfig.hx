package dust.multitouch;

import dust.multitouch.systems.MouseTouchSystem;
import dust.multitouch.data.GestureAction;
import dust.multitouch.systems.DragZoomSystem;
import dust.multitouch.data.CameraDragZoomAction;
import dust.multitouch.data.DragZoomGesture;
import dust.multitouch.control.DragZoomFactory;
import dust.multitouch.systems.MultiTouchSystem;
import dust.multitouch.control.Touches;
import dust.systems.System;
import dust.collections.control.CollectionMap;
import dust.entities.api.Entity;
import dust.geom.data.Position;
import dust.camera.CameraConfig;
import dust.app.data.App;
import dust.math.MathConfig;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.Injector;
import dust.context.Config;
import nme.events.TouchEvent;
import nme.ui.MultitouchInputMode;
import nme.ui.Multitouch;
import dust.context.DependentConfig;

class MultiTouchConfig implements DependentConfig
{
    @inject public var app:App;
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [SystemsConfig, CameraConfig, MathConfig]

    public function configure()
    {
        injector.mapSingleton(Touches);
        injector.mapValue(DragZoomGesture, new DragZoomGesture().setTravel(50));
        injector.mapSingleton(CameraDragZoomAction);
        injector.mapSingleton(DragZoomFactory);

        app.isMultiTouch ? mapMultiTouchSystem() : mapClickTouchSystem();

        systems
            .map(DragZoomSystem)
            .toCollection([GestureAction, DragZoomGesture])
            .withName('DragZoom');
    }

        function mapMultiTouchSystem()
        {
            systems
                .map(MultiTouchSystem)
                .withName('MultiTouch');
        }

        function mapClickTouchSystem()
        {
            systems
                .map(MouseTouchSystem)
                .withName('MultiTouch');
        }
}
