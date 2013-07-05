package dust.graphics.data;

import flash.display.Graphics;
import dust.entities.Entity;

interface Painter
{
    function draw(entity:Entity, graphics:Graphics):Void;
}