package dust.interactive.systems;

import dust.interactive.control.TouchSelector;
import dust.multitouch.control.Touches;
import flash.events.MouseEvent;
import dust.camera.data.Camera;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.interactive.data.Draggable;
import dust.interactive.data.DragFocus;
import dust.interactive.data.TouchFocus;
import dust.interactive.data.TouchInteractive;
import dust.geom.data.Position;
import dust.systems.System;

import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Stage;

class DragSystem implements System
{
    @inject public var touches:Touches;
    @inject public var collection:Collection;
    @inject public var dragFocus:DragFocus;
    @inject public var camera:Camera;
    @inject public var selector:TouchSelector;

    var world:Position;
    var touchCount:Int;
    var touchTarget:Entity;

    public function new()
    {
        world = new Position();
    }

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        var count = touches.getCount();
        if (count != touchCount)
            handleTouchesChange(count);
        else if (touchCount == 1)
            updateCurrentDrag(deltaTime);
    }

        function handleTouchesChange(count:Int)
        {
            touchCount = count;
            switch (touchCount)
            {
                case 1: startDragIfPossible();
                default: endDragIfOngoing();
            }
        }

        function startDragIfPossible()
        {
            touchTarget = selector.select(collection);
            if (touchTarget != null)
                touchTarget.add(dragFocus);
        }

        inline function updateCurrentDrag(deltaTime:Float)
        {
            camera.toWorld(touches.getByIndex(0).current, world);
            if (touchTarget != null)
                touchTarget.get(Position).setToPositionXY(world);
        }

        function endDragIfOngoing()
        {
            if (touchTarget != null)
            {
                touchTarget.remove(DragFocus);
                touchTarget = null;
            }
        }
}
