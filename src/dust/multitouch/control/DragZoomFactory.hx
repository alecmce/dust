package dust.multitouch.control;

import dust.multitouch.data.GestureAction;
import dust.multitouch.data.DragZoomGesture;
import dust.entities.Entities;
import dust.entities.Entity;

class DragZoomFactory
{
    @inject public var entities:Entities;
    @inject public var gesture:DragZoomGesture;
    @inject public var factory:CameraDragZoomActionFactory;

    public function make():Entity
    {
        var entity = entities.require();
        entity.add(gesture);
        entity.add(factory.make());
        return entity;
    }
}
