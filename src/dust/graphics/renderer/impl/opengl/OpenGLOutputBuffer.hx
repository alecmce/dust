package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.data.OutputBuffer;
import openfl.gl.GL;
import openfl.gl.GLFramebuffer;
import openfl.gl.GLRenderbuffer;
import openfl.gl.GLTexture;

class OpenGLOutputBuffer implements OutputBuffer
{
    public var frameBuffer:GLFramebuffer;
    public var texture:GLTexture;
    public var renderBuffer:GLRenderbuffer;

    public function new()
    {
        frameBuffer = GL.createFramebuffer();
        texture = GL.createTexture();
        renderBuffer = GL.createRenderbuffer();
    }

    public function resize(width:Int, height:Int)
    {
        GL.bindFramebuffer(GL.FRAMEBUFFER, frameBuffer);

        GL.bindTexture(GL.TEXTURE_2D, texture);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);

        GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, width, height, 0, GL.RGBA, GL.UNSIGNED_BYTE, null);

        GL.bindRenderbuffer(GL.RENDERBUFFER, renderBuffer);
        GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_COMPONENT16, width, height);

        GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture, 0);
        GL.framebufferRenderbuffer(GL.FRAMEBUFFER, GL.DEPTH_ATTACHMENT, GL.RENDERBUFFER, renderBuffer);

        GL.bindTexture(GL.TEXTURE_2D, null);
        GL.bindRenderbuffer(GL.RENDERBUFFER, null);

        #if js
        GL.bindFramebuffer(GL.FRAMEBUFFER, null);
        #end
    }
}