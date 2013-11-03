package dust.graphics.renderer.impl.flash;

import dust.graphics.renderer.control.VertexBufferFactory;
import flash.display3D.Context3D;
import dust.graphics.renderer.data.VertexBuffer;

class FlashVertexBufferFactory implements VertexBufferFactory
{
    @inject public var context:Context3D;

    public function make(vertexCount:Int, perVertex:Int):VertexBuffer
    {
        if (vertexCount > 0x10000)
            throw "Unable to define a VertexBuffer in Flash bigger than 65536";

        return new FlashVertexBuffer(context, vertexCount, perVertex);
    }

    public function fromArray(array:Array<Float>, perVertex:Int):VertexBuffer
    {
        var vertexCount = Std.int(array.length / perVertex);
        var buffer = new FlashVertexBuffer(context, vertexCount, perVertex);
        for (i in 0...array.length)
            buffer.set(i, array[i]);
        return buffer;
    }
}
