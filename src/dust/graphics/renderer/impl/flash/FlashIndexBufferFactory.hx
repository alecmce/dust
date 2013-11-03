package dust.graphics.renderer.impl.flash;

import dust.graphics.data.IndexTriple;
import flash.display3D.Context3D;
import flash.Vector;
import flash.display3D.IndexBuffer3D;
import dust.graphics.renderer.data.IndexBuffer;
import dust.graphics.renderer.control.IndexBufferFactory;

class FlashIndexBufferFactory implements IndexBufferFactory
{
    @inject public var context:Context3D;

    public function make(count:Int):IndexBuffer
    {
        var buffer = context.createIndexBuffer(count);
        return new FlashIndexBuffer(buffer, count);
    }
}

@:hack class FlashIndexBuffer implements IndexBuffer
{
    public var buffer:IndexBuffer3D;
    public var count:Int;

    var internal:Vector<UInt>;

    public function new(buffer:IndexBuffer3D, count:Int)
    {
        this.buffer = buffer;
        this.count = count;
        internal = new Vector<UInt>(count, true);
    }

    public function set(index:Int, value:Int)
    {
        internal[index] = value;
    }

    public function setTriangle(index:Int, zero:Int, triple:IndexTriple)
    {
        index *= 3;
        internal[index + 0] = zero + triple.a;
        internal[index + 1] = zero + triple.b;
        internal[index + 2] = zero + triple.c;
    }

    public function get(index:Int):Int
    {
        return internal[index];
    }

    public function update()
    {
        buffer.uploadFromVector(internal, 0, count);
    }
}