package dust.graphics.data;

import dust.components.Component;
import dust.entities.api.Entity;

import nme.display.Graphics;

class Painter extends Component
{
    public var priority:Int;

    public function draw(entity:Entity, graphics:Graphics) {}

    public function setPriority(priority:Int):Painter
    {
        this.priority = priority;
        return this;
    }
}
