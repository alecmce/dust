package dust.inspector.ui;

import dust.entities.api.Entity;
import dust.gui.ui.UILabelledSlider;
import dust.inspector.data.InspectedField;
import flash.display.Sprite;

class UIFieldSlider
    extends Sprite,
    implements UIInspectedField
{
    var value:Float;
    var isWritten:Bool;

    var field:InspectedField;
    var slider:UILabelledSlider;

    public function new(field:InspectedField)
    {
        super();
        this.field = field;
    }

    public function setSlider(slider:UILabelledSlider):UIFieldSlider
    {
        addChild(this.slider = slider);
        return this;
    }

    public function update(entity:Entity, deltaTime:Float)
    {
        if (isWritten)
            updateComponentFromWritten(entity);
        else
            updateSliderFromComponent(entity);
    }

        function updateComponentFromWritten(entity:Entity)
        {
            var component = entity.get(field.type);
            Reflect.setField(component, field.field, value);
            isWritten = false;
        }

        function updateSliderFromComponent(entity:Entity)
        {
            var component = entity.get(field.type);
            var value = Reflect.field(component, field.field);
            slider.setValue(value);
        }

    public function updateValue(value:Float)
    {
        this.value = value;
        isWritten = true;
    }

    public function getWidth():Int
        return slider.getWidth()

    public function setWidth(width:Int)
        slider.setWidth(width)
}
