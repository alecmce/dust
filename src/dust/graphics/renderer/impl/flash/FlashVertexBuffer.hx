package dust.graphics.renderer.impl.flash;

import dust.graphics.renderer.data.VertexBufferStructure;
import flash.display3D.VertexBuffer3D;
import flash.display3D.Context3D;
import dust.graphics.renderer.data.VertexBuffer;

class FlashVertexBuffer implements VertexBuffer
{
    public var vertexCount:Int;
    public var perVertex:Int;
    public var structure:Array<VertexBufferStructure>;

    public var buffer:VertexBuffer3D;
    public var array:flash.Vector<Float>;

    public function new(context:Context3D, vertexCount:Int, perVertex:Int)
    {
        this.vertexCount = vertexCount;
        this.perVertex = perVertex;
        this.structure = new Array<VertexBufferStructure>();

        buffer = context.createVertexBuffer(vertexCount, perVertex);
        array = new flash.Vector<Float>(vertexCount * perVertex);
    }

    inline public function set(index:Int, value:Float)
    {
        array[index] = value;
    }

    public function setVertex(index:Int, values:Array<Float>)
    {
        index *= perVertex;
        for (i in 0...values.length)
            array[index + i] = values[i];
    }

    inline public function get(index:Int):Float
    {
        return array[index];
    }

    inline public function apply()
    {
        buffer.uploadFromVector(array, 0, vertexCount);
    }

    public function toString():String
    {
        return '[FlashVertexBuffer ${array.join(",")}]';
    }
}
