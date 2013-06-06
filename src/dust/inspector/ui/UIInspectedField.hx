package dust.inspector.ui;

import dust.entities.api.Entity;

interface UIInspectedField
{
    function update(entity:Entity, deltaTime:Float):Void;
    function setWidth(width:Int):Void;
}