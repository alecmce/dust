package dust.interactive.systems;

import dust.interactive.control.TouchSelector;
import dust.multitouch.control.Touches;
import dust.interactive.data.Touchable;
import dust.camera.data.Camera;
import dust.geom.data.Position;
import dust.systems.System;
import dust.interactive.data.TouchInteractive;
import dust.collections.api.Collection;
import dust.entities.api.Entity;

import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;

class TouchSystem implements System
{
    public static var TOO_LONG_FOR_CLICK = 2.0;

    @inject public var touches:Touches;
    @inject public var collection:Collection;
    @inject public var selector:TouchSelector;

    var touchCount:Int;
    var touchTarget:Entity;
    var elapsedTime:Float;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        var count = touches.getCount();
        if (count != touchCount)
            handleTouchesChange(count);
        else if (touchCount == 1)
            updateSingleTouch(deltaTime);
    }

        function handleTouchesChange(count:Int)
        {
            touchCount = count;
            switch (touchCount)
            {
                case 0: checkForClick();
                case 1: initiatePotentialClick();
                case 2: abandonClick();
            }
        }

            function initiatePotentialClick()
            {
                elapsedTime = 0;
                touchTarget = selector.select(collection);
            }

            inline function updateSingleTouch(deltaTime:Float)
            {
                elapsedTime += deltaTime;
                if (elapsedTime > TOO_LONG_FOR_CLICK)
                    touchTarget = null;
            }

            function checkForClick()
            {
                if (touchTarget != null)
                    touchTarget.get(Touchable).execute(touchTarget);
                touchTarget = null;
            }

            function abandonClick()
            {
                touchTarget = null;
            }
}