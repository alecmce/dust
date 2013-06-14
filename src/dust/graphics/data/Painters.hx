package dust.graphics.data;

import dust.components.Component;
import dust.entities.api.Entity;

import nme.display.Graphics;

class Painters extends Component
{
    var priority:Int;
    var painters:Array<Entity->Graphics->Void>;

    public var draw:Entity->Graphics->Void;

    public function new(priority:Int = 0)
    {
        this.priority = priority;
        this.painters = [];

        this.draw = drawNone;
    }

    public function add(painter:Painter):Painters
    {
        if (draw == drawNone)
            draw = painter.draw;
        else if (draw == drawMultiple)
            painters.push(painter.draw);
        else
            enableMultipleDrawers(painter);

        return this;
    }

        function enableMultipleDrawers(painter:Painter)
        {
            painters.push(draw);
            painters.push(painter.draw);
            draw = drawMultiple;
        }

    public function remove(painter:Painter):Painters
    {
        if (draw == drawMultiple)
            removeFromMultiple(painter);
        else if (draw == painter.draw)
            draw = drawNone;

        return this;
    }

        function removeFromMultiple(painter:Painter)
        {
            for (method in painters)
            {
                if (method == painter.draw)
                    painters.remove(method);
            }

            if (painters.length == 1)
            {
                draw = painters[0];
                untyped painters.length = 0;
            }
        }

    public function setPriority(priority:Int):Painters
    {
        this.priority = priority;
        return this;
    }

    inline public function getPriority():Int
    {
        return priority;
    }

    function drawNone(entity:Entity, graphics:Graphics) {}

    function drawMultiple(entity:Entity, graphics:Graphics)
    {
        for (drawer in painters)
            drawer(entity, graphics);
    }
}
