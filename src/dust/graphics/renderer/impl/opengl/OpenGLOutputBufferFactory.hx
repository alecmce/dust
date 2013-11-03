package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.data.OutputBuffer;
import openfl.gl.GL;
import openfl.gl.GLFramebuffer;
import openfl.gl.GLRenderbuffer;
import openfl.gl.GLTexture;

class OpenGLOutputBufferFactory implements OutputBufferFactory
{
    public function make(isEmpty:Bool):OutputBuffer
    {
        return isEmpty ? new EmptyOpenGLOutputBuffer() : new OpenGLOutputBuffer();
    }
}