package dust.graphics.renderer.impl.flash;

import flash.display3D.textures.Texture;
import dust.graphics.renderer.impl.flash.FlashTexture;
import dust.graphics.renderer.control.TextureFactory;
import dust.graphics.renderer.data.RendererTexture;
import flash.display3D.Context3DTextureFormat;
import flash.geom.Matrix;
import flash.display.BitmapData;
import flash.display3D.Context3D;

class FlashTextureFactory implements TextureFactory
{
    @inject public var context:Context3D;

    var size:Int;
    var mipLevel:Int;

    public function make(source:BitmapData, data:String):RendererTexture
    {
        if (source == null)
            throw 'You cannot make a texture from a null BitmapData source';

        var texture = makeFlashTexture(source);
        var textures = new JsonTextureParser().parse(data);
        return new FlashTexture(texture, textures);
    }

        function makeFlashTexture(source:BitmapData):Texture
        {
            size = getSize(source);
            mipLevel = 0;

            var texture = context.createTexture(1 << size, 1 << size, Context3DTextureFormat.BGRA, false);

            while (size > 0)
            {
                var bitmap = getResizedBitmapData(source);
                texture.uploadFromBitmapData(bitmap, mipLevel);
                bitmap.dispose();

                ++mipLevel;
                --size;
            }

            return texture;
        }

            function getSize(source:BitmapData):Int
            {
                var width = source.width;
                var height = source.height;
                var size:Int = width > height ? width : height;

                return Math.ceil(Math.log(size));
            }

            function getResizedBitmapData(source:BitmapData):BitmapData
            {
                var scalar = 1 / (mipLevel + 1);
                var matrix = new Matrix(scalar, 0, 0, scalar);

                var bitmap = new BitmapData(size << mipLevel, size << mipLevel, source.transparent, 0x00FFFFFF);
                bitmap.draw(source, matrix);
                return bitmap;
            }
}
