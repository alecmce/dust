package dust.ui.components;

import dust.ui.components.ComponentConfig;
import dust.ui.components.SliderHandle;

import nme.display.Shape;
import nme.display.Sprite;
import nme.events.MouseEvent;

class LabelledSlider extends Slider
{
    public function new(update:Float->Void, config:ComponentConfig, text:String, min:Float, max:Float, value:Float)
    {
        super(update, config, min, max, value);
        addChild(makeLabel(text));
    }

        function makeLabel(text:String):Label
        {
            var label:Label = new Label(text);
            label.x = -label.width * 0.5;
            label.y = -label.height * 0.5;
            label.mouseEnabled = false;
            label.mouseChildren = false;
            return label;
        }
}

