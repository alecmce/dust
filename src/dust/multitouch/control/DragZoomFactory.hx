package dust.multitouch.control;

import dust.multitouch.data.GestureAction;
import dust.multitouch.data.CameraDragZoomAction;
import dust.multitouch.data.DragZoomGesture;
import dust.entities.api.Entities;
import dust.entities.api.Entity;

class DragZoomFactory
{
    @inject public var entities:Entities;
    @inject public var gesture:DragZoomGesture;
    @inject public var action:CameraDragZoomAction;

    public function make():Entity
    {
        var entity = entities.require();
        entity.add(gesture);
        entity.addAsType(action, GestureAction);
        return entity;
    }
}