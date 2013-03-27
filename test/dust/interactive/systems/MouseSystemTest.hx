package dust.interactive.systems;

import dust.geom.data.Position;
import dust.interactive.data.ClickFocus;
import dust.camera.CameraConfig;
import dust.components.Component;
import dust.context.Context;
import dust.collections.api.Collection;
import dust.entities.api.Entities;
import dust.entities.api.Entity;
import dust.entities.EntitiesConfig;
import dust.interactive.data.MouseInteractive;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.systems.impl.SystemMap;
import dust.systems.impl.SystemMap;

import dust.Injector;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;

class MouseSystemTest
{
    var injector:Injector;
    var context:Context;
    var root:DisplayObjectContainer;

    var systems:Systems;
    var entities:Entities;

    var entity:Entity;
    var delegate:ClickableDelegate;

    @Before public function before()
    {
        configureDependencies();
        mapSystem();
        referenceInstances();

        entity = makeEntityClickable(entities.require());
        delegate = entity.get(ClickableDelegate);
    }

        function configureDependencies()
        {
            injector = new Injector();
            context = new Context(injector)
                .configure(EntitiesConfig)
                .configure(SystemsConfig)
                .configure(CameraConfig)
                .start(root = new Sprite());
        }

        function mapSystem()
        {
            systems = injector.getInstance(Systems);
            systems
                .map(ClickSystem)
                .toCollection([MouseInteractive])
                .withName("Click");
        }

        function referenceInstances()
        {
            entities = injector.getInstance(Entities);
        }

        function startSystemsAndClick()
        {
            systems.start();
            systems.update();
            root.dispatchEvent(new MouseEvent(MouseEvent.CLICK, false, false, 20, 20));
        }

    @After
    public function after()
    {
        if (root.parent != null)
            root.parent.removeChild(root);
    }

    @Test public function clickablesAreIteratedOver()
    {
        startSystemsAndClick();
        Assert.isTrue(delegate.wasMouseOverCalled);
    }

        function makeEntityClickable(entity:Entity):Entity
        {
            var delegate = new ClickableDelegate();
            entity.add(delegate);
            entity.add(delegate.makeClickable());
            return entity;
        }
}

class ClickableDelegate extends Component
{
    public var x:Float;
    public var y:Float;
    public var wasMouseOverCalled:Bool;
    public var mouseOverIntention:Bool;

    public function new()
    {
        x = -1;
        y = -1;
        wasMouseOverCalled = false;
        mouseOverIntention = false;
    }

    public function makeClickable():MouseInteractive
    {
        return new MouseInteractive(isMouseOver);
    }

    function isMouseOver(entity:Entity, position:Position):Bool
    {
        var data:ClickableDelegate = entity.get(ClickableDelegate);
        data.wasMouseOverCalled = true;
        data.x = position.x;
        data.y = position.y;
        return data.mouseOverIntention;
    }
}
