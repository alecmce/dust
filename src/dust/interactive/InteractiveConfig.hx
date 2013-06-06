package dust.interactive;

import dust.interactive.control.TouchInteractiveFactory;
import dust.interactive.control.TouchSelector;
import dust.multitouch.MultiTouchConfig;
import dust.interactive.data.Touchable;
import dust.interactive.control.DraggableDecorator;
import dust.interactive.control.ReflectionDecorator;
import dust.interactive.control.OffsetDecorator;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.DragFocus;
import dust.interactive.data.Reflection;
import dust.interactive.systems.ReflectionSystem;
import dust.interactive.systems.OffsetSystem;
import dust.interactive.data.Offsets;
import dust.geom.data.Position;
import dust.interactive.systems.DragSystem;
import dust.camera.CameraConfig;
import dust.graphics.GraphicsConfig;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.collections.control.CollectionMap;
import dust.interactive.data.TouchInteractive;
import dust.interactive.systems.TouchSystem;
import dust.interactive.data.Draggable;
import dust.interactive.data.TouchFocus;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;

import dust.Injector;

class InteractiveConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [MultiTouchConfig, GraphicsConfig, SystemsConfig, CameraConfig]

    public function configure()
    {
        injector.mapSingleton(TouchFocus);
        injector.mapSingleton(DragFocus);
        injector.mapSingleton(DraggableDecorator);
        injector.mapSingleton(OffsetDecorator);
        injector.mapSingleton(ReflectionDecorator);
        injector.mapSingleton(TouchSelector);
        injector.mapSingleton(TouchInteractiveFactory);

        systems
            .map(TouchSystem)
            .toCollection([TouchInteractive, Touchable])
            .withName("Click");

        systems
            .map(DragSystem)
            .toCollection([TouchInteractive, Draggable, Position])
            .withName("Drag");

        systems
            .map(ReflectionSystem)
            .toCollection([TouchInteractive, Reflection, Position, DragFocus])
            .withName("Reflection");

        systems
            .map(OffsetSystem)
            .toCollection([TouchInteractive, Offsets, Position, DragFocus])
            .withName("Offset");
    }
}
