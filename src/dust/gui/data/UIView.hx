package dust.gui.data;

import dust.entities.api.Entity;

import nme.display.DisplayObject;

interface UIView
{
    var display:DisplayObject;

    function refresh(entity:Entity, deltaTime:Float):Void;
}
