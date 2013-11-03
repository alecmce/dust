package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.renderer.impl.opengl.OpenGLVertexBuffer;
import dust.graphics.renderer.data.VertexBuffer;

class OpenGLVertexBufferFactory implements VertexBufferFactory
{
    public function make(vertexCount:Int, perVertex:Int):VertexBuffer
    {
        return new OpenGLVertexBuffer(vertexCount, perVertex);
    }

    public function fromArray(array:Array<Float>, perVertex:Int):VertexBuffer
    {
        var vertexCount = Std.int(array.length / perVertex);
        var buffer = new OpenGLVertexBuffer(vertexCount, perVertex);
        for (i in 0...array.length)
            buffer.set(i, array[i]);
        return buffer;
    }
}
