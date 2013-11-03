package dust.graphics.renderer.control;

import dust.graphics.renderer.data.IndexArray;

interface IndexArrayFactory
{
    function make(indices:Int):IndexArray;
}
