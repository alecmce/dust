package dust.inspector.ui;

import flash.display.DisplayObjectContainer;
import dust.inspector.control.UIInspectedFieldFactory;
import dust.inspector.data.Inspector;
import dust.entities.Entity;
import dust.entities.Entity;
import dust.gui.ui.UILabel;
import dust.inspector.data.InspectedField;
import dust.gui.ui.VerticalList;
import dust.gui.data.UIView;
import dust.entities.Entity;
import flash.display.Graphics;
import dust.graphics.data.Painter;
import flash.display.Sprite;

class UIInspector extends UIView
{
    public var target:Entity;
    public var factory:UIInspectedFieldFactory;

    var verticalList:VerticalList;

    var componentHash:IntHash<UIInspectedField>;
    var maxWidth:Int;

    public function new(target:Entity, factory:UIInspectedFieldFactory)
    {
        this.target = target;
        this.factory = factory;

        super();

        maxWidth = -1;
        componentHash = new IntHash<UIInspectedField>();
        verticalList = new VerticalList([], 2);
        cast (display, DisplayObjectContainer).addChild(verticalList);
    }

    override public function refresh(entity:Entity, deltaTime:Float)
    {
        var inspector:Inspector = target.get(Inspector);
        for (field in inspector)
            update(field);
    }

        function update(field:InspectedField)
        {
            var hasField = target.has(field.type);
            var hasComponent = componentHash.exists(field.id);

            if (hasField && hasComponent)
                updateComponent(field);
            else if (hasComponent)
                deleteComponent(field);
            else if (hasField)
                makeComponent(field);
        }

        function makeComponent(field:InspectedField)
        {
            var ui = factory.make(field, maxWidth);
            componentHash.set(field.id, cast ui);
            updateComponent(field);

            if ((cast ui).getWidth() > maxWidth)
                updateWidths((cast ui).getWidth());

            verticalList.addItem(cast ui);
            return ui;
        }

            function updateWidths(width:Int)
            {
                maxWidth = width;
                for (ui in componentHash)
                    ui.setWidth(maxWidth);
            }

        function updateComponent(field:InspectedField)
        {
            var ui = componentHash.get(field.id);
            ui.update(target, 0);
        }

        function deleteComponent(field:InspectedField)
        {
            var ui = componentHash.get(field.id);
            componentHash.remove(field.id);
            verticalList.removeItem(cast ui);
        }
}