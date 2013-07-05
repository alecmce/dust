package dust.gui.ui;

import dust.gui.data.UIContainer;
import dust.entities.Entity;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

class HorizontalList extends Sprite
{
    var items:Array<DisplayObject>;
    var tail:DisplayObject;
    var padding:Int;

    public function new(items:Array<DisplayObject>, padding:Int)
    {
        super();
        this.items = new Array<DisplayObject>();
        this.padding = padding;
        setItems(items);
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
            item.x = padding + tailRect.right - itemRect.left;
        }

    public function removeItem(item:DisplayObject)
    {
        removeChild(item);
        items.remove(item);
    }
}