package dust.graphics.data;

import flash.display.Graphics;
import dust.entities.api.Entity;

interface Painter
{
    function draw(entity:Entity, graphics:Graphics):Void;
}