package dust.gui;

import dust.gui.data.UIContainer;
import dust.entities.Entity;
import dust.gui.data.UIView;

class GUIUtil
{
    public static function addView(entity:Entity, view:UIView)
    {
        var container = getContainer(entity);
        container.add(view);
    }

    public static function getContainer(entity:Entity):UIContainer
    {
        return if (entity.has(UIContainer))
            entity.get(UIContainer);
        else
            makeContainer(entity);
    }

        static function makeContainer(entity:Entity):UIContainer
        {
            var container = new UIContainer();
            entity.add(container);
            return container;
        }

    public static function removeView(entity:Entity, view:UIView)
    {
        if (entity.has(UIContainer))
            entity.get(UIContainer).remove(view);
    }

}
