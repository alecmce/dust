package dust.multitouch.systems;

import dust.app.data.App;
import dust.pooling.data.Pool;
import dust.lists.LinkedList;
import dust.lists.PooledList;
import dust.systems.System;
import dust.multitouch.data.DragZoomGesture;
import dust.multitouch.data.Touch;
import dust.multitouch.control.Touches;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.display.Sprite;
import flash.display.Stage;
import flash.ui.Multitouch;
import flash.events.MouseEvent;
import flash.ui.MultitouchInputMode;

class MouseTouchSystem implements System
{
    static var ID = 0;
    static var DX = 200;
    static var DY = 200;

    @inject public var app:App;
    @inject public var touches:Touches;
    @inject public var stage:Stage;

    var mouseTouch:Touch;
    var secondTouch:Touch;
    var time:Float;

    var isDrag:Bool;
    var isZoom:Bool;

    public function new()
    {
        mouseTouch = new Touch();
        secondTouch = new Touch();
        isDrag = false;
        isZoom = false;
    }

    public function start()
    {
        time = 0;

        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    public function stop()
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

        function onKeyDown(event:KeyboardEvent)
        {
            isZoom = isZoom || event.keyCode == Keyboard.SHIFT;
            isDrag = isDrag || event.keyCode == Keyboard.ENTER;
        }

        function onKeyUp(event:KeyboardEvent)
        {
            isZoom = isZoom && event.keyCode != Keyboard.SHIFT;
            isDrag = isDrag && event.keyCode != Keyboard.ENTER;
        }

        function onMouseDown(event:MouseEvent)
        {
            initTouch(mouseTouch, event.stageX, event.stageY);
            if (isZoom)
                initTouch(secondTouch, app.stageWidth * 0.5, app.stageHeight * 0.5);
            else if (isDrag)
                initTouch(secondTouch, event.stageX + DX, event.stageY + DY);
        }

            function initTouch(touch:Touch, x:Float, y:Float)
            {
                touch.init(++ID, x, y, time);
                touches.add(touch);
            }

        function onMouseMove(event:MouseEvent)
        {
            updateTouch(mouseTouch, event.stageX, event.stageY);
            if (isDrag)
                updateTouch(secondTouch, event.stageX + DX, event.stageY + DY);
        }

            function updateTouch(touch:Touch, x:Float, y:Float)
            {
                touch.update(x, y, time);
            }

        function onMouseUp(event:MouseEvent)
        {
            clearTouch(mouseTouch);
            if (isZoom || isDrag)
                clearTouch(secondTouch);

            isDrag = false;
            isZoom = false;
        }

            function clearTouch(touch:Touch)
            {
                touches.remove(touch);
                touch.clear();
            }

    public function iterate(deltaTime:Float)
    {
        time += deltaTime;
    }
}