package dust.interactive.data;

import flash.display.Graphics;
import dust.geom.data.Position;
import dust.entities.Entity;

typedef TouchInteractiveResponse = {isAtPosition:Bool, distance:Float};

interface TouchInteractive
{
    function isAtPosition(entity:Entity, mouse:Position):TouchInteractiveResponse;
}

interface DrawableTouchInteractive extends TouchInteractive
{
    function draw(entity:Entity, graphics:Graphics):Void;
}