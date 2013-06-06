package dust.gui.data;

import dust.entities.api.Entity;
import dust.components.Component;
import nme.display.Sprite;
import nme.geom.Rectangle;

class UIView extends Component
{
    public var display:Sprite;

    public function new()
        this.display = new Sprite()

    public function setDisplay(display:Sprite):UIView
    {
        this.display = display;
        return this;
    }

    public function refresh(entity:Entity, deltaTime:Float) {}
}
