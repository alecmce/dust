package dust.graphics.renderer.control;

import flash.display.BitmapData;
import dust.graphics.renderer.data.RendererTexture;

interface TextureFactory
{
    public function make(source:BitmapData, data:String):RendererTexture;
}
