package dust.graphics.renderer.control;

import flash.geom.Rectangle;

interface Renderer
{
    function addRenderCall(call:Int->Int->Void):Void;
    function removeRenderCall(call:Int->Int->Void):Void;
}