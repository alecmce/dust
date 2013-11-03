package dust.graphics.renderer.impl.opengl;

import openfl.utils.Float32Array;
import dust.graphics.renderer.data.VertexBuffer;
import dust.graphics.renderer.data.VertexBufferStructure;
import openfl.gl.GL;
import openfl.gl.GLBuffer;

class OpenGLVertexBuffer implements VertexBuffer
{
    public var vertexCount:Int;
    public var perVertex:Int;
    public var structure:Array<VertexBufferStructure>;

    public var buffer:GLBuffer;
    public var array:Float32Array;

    public function new(vertexCount:Int, perVertex:Int)
    {
        this.vertexCount = vertexCount;
        this.perVertex = perVertex;
        this.structure = new Array<VertexBufferStructure>();

        buffer = GL.createBuffer();
        array = new Float32Array(vertexCount * perVertex);
    }

    public function set(index:Int, value:Float)
    {
        array[index] = value;
    }

    public function setVertex(index:Int, values:Array<Float>)
    {
        index *= perVertex;
        for (i in 0...values.length)
            array[index + i] = values[i];
    }

    public function get(index:Int):Float
    {
        return array[index];
    }
    
    public function toString():String
    {
        var list = new Array<Float>();
        for (i in 0...array.length)
            list[i] = array[i];

        return '[OpenGLVertexBuffer ${list.join(",")}]';
    }

}
