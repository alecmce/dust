package dust.gui.ui;

import dust.gui.data.UISliderData;
import dust.gui.ui.UISliderHandle;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class UILabelledSlider extends Sprite
{
    var slider:UISlider;
    var label:UILabel;

    public function setSlider(slider:UISlider):UILabelledSlider
    {
        addChild(this.slider = slider);
        return this;
    }

    public function setLabel(label:UILabel):UILabelledSlider
    {
        label.x = -slider.data.width * 0.5;
        label.y = -slider.data.height * 0.5;
        addChild(this.label = label);
        return this;
    }

    public function enable():UILabelledSlider
    {
        slider.enable();
        return this;
    }

    public function disable():UILabelledSlider
    {
        slider.disable();
        return this;
    }

    public function getValue():Float
        return slider.getValue()

    public function setValue(v:Float)
        slider.setValue(v)

    public function getWidth():Int
        return label.getWidth()

    public function setWidth(width:Int)
    {
        slider.setWidth(width);
        label.setWidth(width);
    }
}

