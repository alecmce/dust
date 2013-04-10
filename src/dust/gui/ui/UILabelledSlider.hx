package dust.gui.ui;

import dust.gui.data.UISliderData;
import dust.gui.ui.UISliderHandle;

import nme.display.Shape;
import nme.display.Sprite;
import nme.events.MouseEvent;

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

    public function enable()
        slider.enable()

    public function disable()
        slider.disable()
}

