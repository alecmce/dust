package dust.graphics.renderer.impl.opengl;

import dust.graphics.data.IndexTriple;
import openfl.gl.GL;
import dust.graphics.renderer.data.IndexArray;
import openfl.gl.GLBuffer;
import dust.graphics.renderer.data.IndexBuffer;
import dust.graphics.renderer.control.IndexBufferFactory;

class OpenGLIndexBufferFactory implements IndexBufferFactory
{
    public function make(count:Int):IndexBuffer
    {
        return new OpenGLIndexBuffer(count);
    }
}

class OpenGLIndexBuffer implements IndexBuffer
{
    public var count:Int;

    public var buffer:GLBuffer;
    public var array:IndexArray;

    public function new(count:Int)
    {
        this.count = count;

        buffer = GL.createBuffer();
        array = new IndexArray(count);
    }

    public function set(index:Int, value:Int)
    {
        array[index] = value;
    }

    public function setTriangle(index:Int, zero:Int, triple:IndexTriple)
    {
        index *= 3;
        array[index + 0] = zero + triple.a;
        array[index + 1] = zero + triple.b;
        array[index + 2] = zero + triple.c;
    }

    public function get(index:Int):Int
    {
        return array[index];
    }

    public function update()
    {
        GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, buffer);
        GL.bufferData(GL.ELEMENT_ARRAY_BUFFER, array, GL.STATIC_DRAW);
    }

    public function toString():String
    {
        var list = new Array<Int>();
        for (i in 0...array.length)
            list.push(array[i]);

        return '[OpenGLIndexBuffer ${list.join(",")}]';
    }
}