package dust.ui.systems;

import dust.context.Config;
import dust.context.DependentConfig;
import dust.collections.api.Collection;
import dust.collections.api.CollectionListeners;
import dust.entities.api.Entity;
import dust.ui.api.UIView;

import minject.Injector;
import nme.display.DisplayObjectContainer;

class UIViewRootManager implements CollectionListeners
{
    public function onEntityAdded(entity:Entity)
    {
        var view:UIView = entity.get(UIView);
        root().addChild(view.display);
    }

    public function onEntityRemoved(entity:Entity)
    {
        var view:UIView = entity.get(UIView);
        root().removeChild(view.display);
    }

        function root():DisplayObjectContainer
            return cast nme.Lib.current
}