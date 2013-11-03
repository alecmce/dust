package dust.graphics.renderer.control;

import dust.graphics.renderer.data.VertexBuffer;

interface VertexBufferFactory
{
    function make(vertexCount:Int, perVertex:Int):VertexBuffer;
    function fromArray(array:Array<Float>, perVertex:Int):VertexBuffer;
}
