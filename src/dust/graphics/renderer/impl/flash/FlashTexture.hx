package dust.graphics.renderer.impl.flash;

import dust.graphics.renderer.data.RendererTexture;

class FlashTexture implements dust.graphics.renderer.data.RendererTexture
{
    var texture:flash.display3D.textures.Texture;
    var textures:Map<String, dust.graphics.data.Texture>;

    public function new(texture:flash.display3D.textures.Texture, textures:Map<String, dust.graphics.data.Texture>)
    {
        this.texture = texture;
        this.textures = textures;
    }

    public function get(key:String):dust.graphics.data.Texture
    {
        return textures.get(key);
    }
}
