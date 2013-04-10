package dust.gui.control;

import dust.gui.data.UISliderData;
import dust.gui.ui.UISlider;

class UISliderFactory
{
    public function make(data:UISliderData):UISlider
    {
        return new UISlider(data);
    }
}
