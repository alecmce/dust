package dust.ui.components;

import nme.display.Sprite;
import nme.events.MouseEvent;

class SliderHandle extends Sprite
{
    var update:Float->Void;
    var config:ComponentConfig;
    var size:Float;

    public function new(update:Float->Void, config:ComponentConfig)
    {
        super();
        this.update = update;
        this.config = config;
        setSize(config.sliderHeight);
    }

    public function setSize(size:Float)
    {
        this.size = size;
        redraw();
    }

        function redraw()
        {
            graphics.clear();
            graphics.beginFill(config.sliderBackgroundColor);
            graphics.drawRect(-size * 0.5, -size * 0.5, size, size);
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