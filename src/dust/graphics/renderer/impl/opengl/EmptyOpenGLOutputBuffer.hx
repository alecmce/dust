package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.data.OutputBuffer;
import openfl.gl.GL;
import openfl.gl.GLFramebuffer;
import openfl.gl.GLRenderbuffer;
import openfl.gl.GLTexture;

class EmptyOpenGLOutputBuffer implements OutputBuffer
{
    public function new() {}

    public function resize(width:Int, height:Int)
    {
        GL.viewport(0, 0, width, height);
    }
}
