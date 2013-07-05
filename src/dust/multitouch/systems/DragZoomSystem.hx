package dust.multitouch.systems;

import dust.camera.data.Camera;
import dust.collections.api.Collection;
import dust.entities.Entity;
import dust.systems.System;
import dust.multitouch.control.Touches;
import dust.multitouch.data.DragZoomGesture;
import dust.multitouch.data.GestureAction;

class DragZoomSystem implements System
{
    @inject public var touches:Touches;
    @inject public var gesture:DragZoomGesture;
    @inject public var collection:Collection;

    var touchCount:Int;
    var isZoom:Bool;
    var scalar:Float;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        var count = touches.getCount();
        if (touchCount != count)
            count == 2 ? initGesture() : endGesture();
        else if (touchCount == 2)
            checkGesture();
        touchCount = count;
    }

        inline function initGesture()
        {
            var first = touches.getByIndex(0);
            var second = touches.getByIndex(1);
            gesture.init(first, second);
            for (entity in collection)
                entity.get(GestureAction).start();
        }

        inline function checkGesture()
        {
            gesture.update();
            if (gesture.isActive)
            {
                for (entity in collection)
                    entity.get(GestureAction).update();
            }
        }

        inline function endGesture()
        {
            if (gesture.isActive)
            {
                for (entity in collection)
                    entity.get(GestureAction).end();
            }

            gesture.clear();
            isZoom = false;
        }
}
