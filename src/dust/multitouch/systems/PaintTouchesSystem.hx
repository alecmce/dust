package dust.multitouch.systems;

import flash.display.DisplayObjectContainer;
import dust.multitouch.data.Touch;
import dust.math.Random;
import flash.display.Sprite;
import dust.lists.Pool;
import dust.lists.LinkedList;
import dust.lists.PooledList;
import dust.multitouch.control.Touches;
import flash.ui.Multitouch;
import flash.events.TouchEvent;
import flash.ui.MultitouchInputMode;
import dust.systems.System;

class PaintTouchesSystem implements System
{
    @inject public var touches:Touches;
    @inject public var random:Random;
    @inject public var root:DisplayObjectContainer;

    var sprites:IntHash<Sprite>;

    public function new()
    {
        sprites = new IntHash<Sprite>();
    }

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (touch in touches)
        {
            var id = touch.id;
            if (sprites.exists(id))
                updateTouchSprite(touch);
            else
                makeTouchSprite(touch);
        }

        for (key in sprites.keys())
        {
            if (!touches.has(key))
                removeTouchSprite(key);
        }
    }

    function makeTouchSprite(touch:Touch)
        sprites.set(touch.id, makeSprite(touch.current.x, touch.current.y))

        function makeSprite(x:Float, y:Float):Sprite
        {
            var sprite = new Sprite();
            sprite.graphics.beginFill(random.color());
            sprite.graphics.drawCircle(0, 0, 100);
            sprite.graphics.endFill();
            sprite.x = x;
            sprite.y = y;
            root.addChild(sprite);
            return sprite;
        }

    function updateTouchSprite(touch:Touch)
    {
        var id = touch.id;
        var sprite = sprites.get(id);
        sprite.x = touch.current.x;
        sprite.y = touch.current.y;
    }

    function removeTouchSprite(id:Int)
    {
        var sprite = sprites.get(id);
        root.removeChild(sprite);
        sprites.remove(id);
    }
}

