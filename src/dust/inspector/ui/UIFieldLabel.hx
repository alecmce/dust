package dust.inspector.ui;

import flash.display.Sprite;
import dust.gui.data.Color;
import dust.entities.api.Entity;
import dust.inspector.data.InspectedField;
import dust.gui.ui.UILabel;

class UIFieldLabel
    extends Sprite,
    implements UIInspectedField
{
    public var nameLabel:UILabel;
    public var valueLabel:UILabel;

    var field:InspectedField;

    public function new(field:InspectedField)
    {
        super();
        this.field = field;
    }

    public function setNameLabel(label:UILabel):UIFieldLabel
    {
        addChild(nameLabel = label);
        return this;
    }

    public function setDisplayLabel(label:UILabel):UIFieldLabel
    {
        addChild(valueLabel = label);
        valueLabel.y = nameLabel.height;
        return this;
    }

    public function setWidth(width:Int)
    {
        nameLabel.setWidth(width);
        valueLabel.setWidth(width);
    }

    public function getWidth():Int
    {
        var name = nameLabel.getWidth();
        var label = valueLabel.getWidth();
        return name > label ? name : label;
    }

    public function update(entity:Entity, deltaTime:Float)
    {
        var component = entity.get(field.type);
        var value = Reflect.field(component, field.field);
        valueLabel.setLabel(Std.string(value));
    }
}