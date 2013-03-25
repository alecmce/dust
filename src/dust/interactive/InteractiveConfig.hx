package dust.interactive;

import dust.interactive.data.Clickable;
import dust.interactive.control.MouseInteractiveDecorator;
import dust.interactive.control.DraggableDecorator;
import dust.interactive.control.ReflectionDecorator;
import dust.interactive.control.OffsetDecorator;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.MouseInteractive;
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
import dust.interactive.data.MouseInteractive;
import dust.interactive.systems.ClickSystem;
import dust.interactive.data.Draggable;
import dust.interactive.data.ClickFocus;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;

import minject.Injector;

class InteractiveConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var collections:CollectionMap;
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [GraphicsConfig, SystemsConfig, CameraConfig]

    public function configure()
    {
        injector.mapSingleton(ClickFocus);
        injector.mapSingleton(DragFocus);
        injector.mapSingleton(MouseInteractiveDecorator);
        injector.mapSingleton(DraggableDecorator);
        injector.mapSingleton(OffsetDecorator);
        injector.mapSingleton(ReflectionDecorator);

        systems
            .map(ClickSystem)
            .toCollection([MouseInteractive, Clickable])
            .withName("Click");

        systems
            .map(DragSystem)
            .toCollection([MouseInteractive, Draggable, Position])
            .withName("Drag");

        systems
            .map(ReflectionSystem)
            .toCollection([MouseInteractive, Reflection, Position, DragFocus])
            .withName("Reflection");

        systems
            .map(OffsetSystem)
            .toCollection([MouseInteractive, Offsets, Position, DragFocus])
            .withName("Offset");
    }
}
