package dust.graphics.renderer.impl.flash;

import flash.display.BitmapData;
import flash.display3D.Context3D;
import dust.graphics.renderer.data.OutputBuffer;
import dust.graphics.renderer.control.OutputBufferFactory;

class FlashOutputBufferFactory implements OutputBufferFactory
{
    @inject public var context:Context3D;

    public function make(isEmpty:Bool):OutputBuffer
    {
        return isEmpty ? new EmptyFlashOutputBuffer(context) : new FlashOutputBuffer(context);
    }
}

class FlashOutputBuffer implements OutputBuffer
{
    public var bitmapData:BitmapData;

    var context:Context3D;

    public function new(context:Context3D)
    {
        this.context = context;
        bitmapData = new BitmapData(1, 1, true, 0);
    }

    public function resize(width:Int, height:Int)
    {
        if (bitmapData != null)
            bitmapData.dispose();
        bitmapData = new BitmapData(width, height, true, 0);
    }
}

class EmptyFlashOutputBuffer implements OutputBuffer
{
    var context:Context3D;

    public function new(context:Context3D)
    {
        this.context = context;
    }

    public function resize(width:Int, height:Int)
    {
        context.configureBackBuffer(width, height, 2, true);
    }
}

