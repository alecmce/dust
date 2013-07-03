package dust.gui.systems;

import dust.collections.api.Collection;
import dust.collections.api.CollectionListeners;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.api.Entity;
import dust.gui.data.UIContainer;

import dust.Injector;
import flash.display.DisplayObjectContainer;

class UIRootManager implements CollectionListeners
{
    var root:DisplayObjectContainer;

    public function new()
    {
        root = cast nme.Lib.current;
    }

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