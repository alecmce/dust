package dust.ui.components;

import dust.entities.api.Entity;

import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;

class VerticalList extends Sprite
{
    var items:Array<DisplayObject>;
    var tail:DisplayObject;
    var padding:Int;

    public function new(items:Array<DisplayObject>, padding:Int)
    {
        super();
        this.items = new Array<DisplayObject>();
        setItems(items);
        this.padding = padding;
    }

    public function clearItems()
    {
        for (item in items)
            removeChild(item);
    }

    public function setItems(items:Array<DisplayObject>)
    {
        clearItems();
        for (item in items)
            addItem(item);
    }

    public function addItem(item:DisplayObject)
    {
        addChild(item);
        items.push(item);
        if (tail != null)
            layoutItem(item);
        tail = item;
    }

        function layoutItem(item:DisplayObject)
        {
            var tailRect = tail.getRect(this);
            var itemRect = item.getRect(item);
            item.y = tailRect.bottom - itemRect.top;
        }

    public function removeItem(item:DisplayObject)
    {
        removeChild(item);
        items.remove(item);
    }
}