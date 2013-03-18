package dust.interactive.control;

import nme.events.MouseEvent;
import dust.camera.data.Camera;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.interactive.data.Draggable;
import dust.interactive.data.DragFocus;
import dust.interactive.data.ClickFocus;
import dust.interactive.data.MouseInteractive;
import dust.geom.Position;
import dust.systems.System;

import nme.display.DisplayObjectContainer;
import nme.display.InteractiveObject;
import nme.display.Stage;

class DragSystem implements System
{
    @inject
    public var root:DisplayObjectContainer;

    @inject
    public var collection:Collection;

    @inject
    public var dragFocus:DragFocus;

    @inject
    public var camera:Camera;

    var screen:Position;
    var world:Position;
    var focus:Entity;

    var isJustDown:Bool;
    var isDown:Bool;
    var isDrag:Bool;

    public function new()
    {
        screen = new Position();
        world = new Position();
        focus = null;
    }

    public function start()
    {
        root.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
        nme.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
    }

    function onDown(_) isJustDown = true
    function onUp(_) isDown = false

    public function stop()
    {
        root.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
        nme.Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
    }

    public function iterate(deltaTime:Float)
    {
        if (isDrag || isJustDown)
        {
            translatePosition();
            if (isDrag)
                updateDrag(isDown);
            else if (isJustDown)
                checkForDrag();
        }
    }

        inline function translatePosition()
        {
            screen.set(root.mouseX, root.mouseY);
            camera.toWorld(screen, world);
        }

        inline function updateDrag(isDown:Bool)
        {
            isDown ? continueDrag() : endDrag();
        }

            inline function continueDrag()
            {
                focus.get(Position).setToPositionXY(world);
            }

            inline function endDrag()
            {
                focus.remove(DragFocus);
                focus = null;
                isDrag = false;
            }

        inline function checkForDrag()
        {
            isDown = true;
            isJustDown = false;

            for (entity in collection)
            {
                if (entity.get(MouseInteractive).isMouseOver(entity, world))
                    startDrag(entity);
            }
        }

            inline function startDrag(entity:Entity)
            {
                entity.add(dragFocus);
                focus = entity;
                isDrag = true;
            }
}
