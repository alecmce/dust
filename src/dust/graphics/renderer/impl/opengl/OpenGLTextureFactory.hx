package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.control.TextureFactory;
import dust.graphics.renderer.data.RendererTexture;
import flash.display.BitmapData;

class OpenGLTextureFactory implements TextureFactory
{
    public function make(source:BitmapData, data:String):RendererTexture
    {
        var textures = new JsonTextureParser().parse(data);
        return new OpenGLRendererTexture(source, textures);
    }
}
