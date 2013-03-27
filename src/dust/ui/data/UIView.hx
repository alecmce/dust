package dust.ui.data;

import nme.display.Sprite;
import nme.geom.Rectangle;
import dust.components.Component;

class UIView extends Component
{
    public var display:Sprite;

    public function new()
        display = new Sprite()

    public function refresh(deltaTime:Float) {}
}
