package dust.interactive.systems;

import dust.interactive.data.Clickable;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.systems.System;
import dust.components.Component;
import dust.interactive.data.MouseInteractive;
import dust.interactive.data.Draggable;
import dust.collections.api.Collection;
import dust.collections.api.CollectionListeners;
import dust.entities.api.Entity;

import nme.display.DisplayObjectContainer;
import nme.display.InteractiveObject;
import nme.events.MouseEvent;

class ClickSystem implements System
{
    @inject public var root:DisplayObjectContainer;
    @inject public var collection:Collection;
    @inject public var camera:Camera;

    var screen:Position;
    var world:Position;

    var isClick:Bool;

    public function new()
    {
        screen = new Position();
        world = new Position();
    }

    public function start()
    {
        var stage = nme.Lib.current.stage;
        stage.addEventListener(MouseEvent.CLICK, onClick);
    }

        function onClick(_)
            isClick = true

    public function stop()
    {
        var stage = nme.Lib.current.stage;
        stage.removeEventListener(MouseEvent.CLICK, onClick);
    }

    public function iterate(deltaTime:Float)
    {
        if (isClick)
            findClickTarget();
        isClick = false;
    }

        inline function findClickTarget()
        {
            translatePosition();
            lookForClickTarget();
        }

        inline function translatePosition()
        {
            screen.set(root.mouseX, root.mouseY);
            camera.toWorld(screen, world);
        }

            function lookForClickTarget()
            {
                for (entity in collection)
                    if (isClicked(entity))
                        return;
            }

                inline function isClicked(entity:Entity)
                {
                    var interactive:MouseInteractive = entity.get(MouseInteractive);
                    var isClick = interactive.isMouseOver(entity, world);
                    if (isClick)
                        entity.get(Clickable).execute(entity);
                    return isClick;
                }
}