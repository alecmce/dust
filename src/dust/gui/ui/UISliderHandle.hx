package dust.gui.ui;

import dust.gui.data.UISliderData;
import nme.display.Sprite;
import nme.events.MouseEvent;

class UISliderHandle extends Sprite
{
    var update:Float->Void;
    var data:UISliderData;

    public function new(update:Float->Void, data:UISliderData)
    {
        super();
        this.update = update;
        this.data = data;
        redraw();
    }

    public function redraw()
    {
        graphics.clear();
        graphics.beginFill(data.handleColor);
        graphics.drawRect(-data.handleSize * 0.5, -data.handleSize * 0.5, data.handleSize, data.handleSize);
        graphics.endFill();
    }

    public function enable()
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown)

    function onMouseDown(_)
    {
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    function onMouseMove(event:MouseEvent)
        update(parent.mouseX)

    public function disable()
    {
        removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        onMouseUp();
    }

        function onMouseUp(_ = null)
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        }

}