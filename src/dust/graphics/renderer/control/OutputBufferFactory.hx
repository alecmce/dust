package dust.graphics.renderer.control;

import dust.graphics.renderer.data.OutputBuffer;

interface OutputBufferFactory
{
    function make(isEmpty:Bool):OutputBuffer;
}
