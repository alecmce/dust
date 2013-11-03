package dust.graphics.renderer.control;

import dust.graphics.renderer.data.IndexBuffer;

interface IndexBufferFactory
{
    function make(count:Int):IndexBuffer;
}
