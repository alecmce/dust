package dust.graphics.renderer.impl.opengl;

import dust.graphics.data.Texture;
import flash.display.BitmapData;
import dust.graphics.renderer.data.RendererTexture;

class OpenGLRendererTexture implements RendererTexture
{
    public var source:BitmapData;

    var textures:Map<String, Texture>;

    public function new(source:BitmapData, textures:Map<String, Texture>)
    {
        this.source = source;
        this.textures = textures;
    }

    public function get(key:String):Texture
    {
        var texture = textures.get(key);
        if (texture == null)
            throw 'No texture found for key $key';

        return texture;
    }
}
