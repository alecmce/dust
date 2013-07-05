package dust.gui.data;

import dust.entities.Entity;
import flash.display.Sprite;
import flash.geom.Rectangle;

class UIContainer
{
    public var display:Sprite;
    var list:Array<UIView>;

    public function new()
    {
        this.display = new Sprite();
        this.list = [];
    }

    public function add(view:UIView):UIContainer
    {
        list.push(view);
        display.addChild(view.display);
        return this;
    }

    public function remove(view:UIView):UIContainer
    {
        list.remove(view);
        display.removeChild(view.display);
        return this;
    }

    public function refresh(entity:Entity, deltaTime:Float)
    {
        for (view in list)
            view.refresh(entity, deltaTime);
    }

    public function iterator():Iterator<UIView>
        return list.iterator();
}
