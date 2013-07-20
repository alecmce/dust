package dust.gui.systems;

import dust.collections.api.CollectionListeners;
import dust.entities.Entity;
import dust.gui.data.UIContainer;

import flash.display.DisplayObjectContainer;

class UIRootManager implements CollectionListeners
{
    @inject public var root:DisplayObjectContainer;

    public function onEntityAdded(entity:Entity)
    {
        var container:UIContainer = entity.get(UIContainer);
        root.addChild(container.display);
    }

    public function onEntityRemoved(entity:Entity)
    {
        var container:UIContainer = entity.get(UIContainer);
        root.removeChild(container.display);
    }
}