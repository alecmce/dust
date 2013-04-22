package dust.multitouch.systems;

import dust.multitouch.data.DragZoomGesture;
import dust.multitouch.data.Touch;
import nme.display.Sprite;
import dust.lists.Pool;
import dust.lists.LinkedList;
import dust.lists.PooledList;
import dust.multitouch.control.Touches;
import nme.ui.Multitouch;
import nme.events.TouchEvent;
import nme.ui.MultitouchInputMode;
import dust.systems.System;

class MultiTouchSystem implements System
{
    @inject public var touches:Touches;

    var pool:Pool<Touch>;

    var events:Array<TouchEvent>;
    var beginEvents:IntHash<Bool>;
    var moveEvents:IntHash<Bool>;
    var endEvents:IntHash<Bool>;

    var time:Float;

    public function new()
    {
        pool = new Pool<Touch>(Touch.make);
        pool.populate(4);

        events = new Array<TouchEvent>();
        beginEvents = new IntHash<Bool>();
        moveEvents = new IntHash<Bool>();
        endEvents = new IntHash<Bool>();
    }

    public function start()
    {
        Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

        time = 0;

        var stage = nme.Lib.current.stage;
        stage.addEventListener(TouchEvent.TOUCH_BEGIN, queueBeginEvent);
        stage.addEventListener(TouchEvent.TOUCH_MOVE, queueMoveEvent);
        stage.addEventListener(TouchEvent.TOUCH_END, queueEndEvent);
    }

    public function stop()
    {
        var stage = nme.Lib.current.stage;
        stage.removeEventListener(TouchEvent.TOUCH_BEGIN, queueBeginEvent);
        stage.removeEventListener(TouchEvent.TOUCH_MOVE, queueMoveEvent);
        stage.removeEventListener(TouchEvent.TOUCH_END, queueEndEvent);
    }

        function queueBeginEvent(event:TouchEvent)
            queueEventIfUnmarked(event, beginEvents)

        function queueMoveEvent(event:TouchEvent)
            queueEventIfUnmarked(event, moveEvents)

        function queueEndEvent(event:TouchEvent)
            queueEventIfUnmarked(event, endEvents)

            inline function queueEventIfUnmarked(event:TouchEvent, hash:IntHash<Bool>)
            {
                var id = event.touchPointID;
                if (!hash.exists(id))
                {
                    events.push(event);
                    hash.set(id, true);
                }
            }

    public function iterate(deltaTime:Float)
    {
        time += deltaTime;
        for (event in events)
        {
            var id = event.touchPointID;
            switch (event.type)
            {
                case TouchEvent.TOUCH_BEGIN:
                    startTouch(event);
                    beginEvents.remove(id);
                case TouchEvent.TOUCH_MOVE:
                    updateTouch(event);
                    moveEvents.remove(id);
                case TouchEvent.TOUCH_END:
                    endTouch(event);
                    endEvents.remove(id);
            }
        }

        untyped events.length = 0;
    }

        inline function startTouch(event:TouchEvent)
        {
            var touch = pool.require();
            touch.init(event.touchPointID, event.stageX, event.stageY, time);
            touches.add(touch);
        }

        inline function updateTouch(event:TouchEvent)
        {
            var touch = touches.get(event.touchPointID);
            touch.update(event.stageX, event.stageY, time);
        }

        inline function endTouch(event:TouchEvent)
        {
            var touch = touches.get(event.touchPointID);
            touch.clear();
            touches.remove(touch);
            pool.release(touch);
        }
}