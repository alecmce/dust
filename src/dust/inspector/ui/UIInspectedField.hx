package dust.inspector.ui;

import dust.entities.Entity;

interface UIInspectedField
{
    function update(entity:Entity, deltaTime:Float):Void;
    function setWidth(width:Int):Void;
}