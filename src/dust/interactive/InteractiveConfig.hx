package dust.interactive;

import dust.interactive.data.Clickable;
import dust.interactive.config.MouseInteractiveDecorator;
import dust.interactive.config.DraggableDecorator;
import dust.interactive.config.ReflectionDecorator;
import dust.interactive.config.OffsetDecorator;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.DragFocus;
import dust.interactive.data.Reflection;
import dust.interactive.control.ReflectionSystem;
import dust.interactive.control.OffsetSystem;
import dust.interactive.data.Offsets;
import dust.geom.data.Position;
import dust.interactive.control.DragSystem;
import dust.camera.CameraConfig;
import dust.canvas.CanvasConfig;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.collections.control.CollectionMap;
import dust.interactive.data.MouseInteractive;
import dust.interactive.control.ClickSystem;
import dust.interactive.data.Draggable;
import dust.interactive.data.ClickFocus;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;

import minject.Injector;

class InteractiveConfig implements DependentConfig
{
    @inject
    public var injector:Injector;

    @inject
    public var collections:CollectionMap;

    @inject
    public var systems:Systems;

    public function dependencies():Array<Class<Config>>
    {
        return [CanvasConfig, SystemsConfig, CameraConfig];
    }

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
