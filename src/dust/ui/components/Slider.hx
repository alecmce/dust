package dust.ui.components;

import dust.ui.components.ComponentConfig;
import dust.ui.components.SliderHandle;
import nme.events.MouseEvent;
import nme.display.Shape;
import nme.display.Sprite;

class Slider extends Sprite
{
    var update:Float->Void;
    var config:ComponentConfig;

    var _width:Int;
    var _height:Int;
    var handle:SliderHandle;

    var value:Float;
    var min:Float;
    var max:Float;

    public function new(update:Float->Void, config:ComponentConfig, min:Float, max:Float, value:Float)
    {
        super();
        this.update = update;
        this.config = config;

        this.handle = new SliderHandle(onHandleMove, config);
        this.value = value;
        setSize(config.sliderWidth, config.sliderHeight);
        setRange(min, max);
        addChild(handle);
    }

        function onHandleMove(x:Float)
            setValue(min + (max - min) * (0.5 + x / (width - height)))

    public function getValue():Float
        return value

    public function setRange(min:Float, max:Float)
    {
        this.min = min;
        this.max = max;
        setValue(value);
    }

    public function setValue(v:Float)
    {
        value = v < min ? min : (v > max ? max : v);
        var p = ((value - min) / (max - min)) - 0.5;
        handle.x = p * (_width - _height);
        update(value);
    }

    public function setSize(width:Int, height:Int)
    {
        _width = width;
        _height = height;

        graphics.clear();
        graphics.beginFill(config.sliderBackgroundColor);
        graphics.drawRect(-_width * 0.5, -_height * 0.5, _width, _height);
        graphics.endFill();

        handle.setSize(_height);
    }

    public function enable()
        handle.enable()

    public function disable()
        handle.disable()
}

