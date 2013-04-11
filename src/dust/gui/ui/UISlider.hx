package dust.gui.ui;

import dust.gui.data.UISliderData;
import dust.gui.ui.UISliderHandle;
import nme.events.MouseEvent;
import nme.display.Shape;
import nme.display.Sprite;

class UISlider extends Sprite
{
    public var data:UISliderData;
    public var handle:UISliderHandle;

    public function new(data:UISliderData)
    {
        super();
        this.data = data;

        this.handle = new UISliderHandle(onHandleMove, data);
        redraw();
        updateHandle();
        addChild(handle);
    }

        function onHandleMove(x:Float)
            setValue(data.min + (data.max - data.min) * (0.5 + x / (data.width- data.height)))

    public function getValue():Float
        return data.value

    public function setValue(v:Float)
    {
        data.value = v < data.min ? data.min : (v > data.max ? data.max : v);
        updateHandle();
    }

    inline function updateHandle()
    {
        var p = ((data.value - data.min) / (data.max - data.min)) - 0.5;
        handle.x = p * (data.width - data.height);
        data.update(data.value);
    }

    public function setWidth(value:Int)
    {
        data.width = value;
        redraw();
    }

    public function redraw()
    {
        graphics.clear();
        graphics.beginFill(data.backgroundColor);
        graphics.drawRect(-data.width * 0.5, -data.height * 0.5, data.width, data.height);
        graphics.endFill();

        handle.redraw();
    }

    public function enable()
        handle.enable()

    public function disable()
        handle.disable()
}

