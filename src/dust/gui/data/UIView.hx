package dust.gui.data;

import dust.entities.Entity;

import flash.display.DisplayObject;

interface UIView
{
    var display:DisplayObject;

    function refresh(entity:Entity, deltaTime:Float):Void;
}
