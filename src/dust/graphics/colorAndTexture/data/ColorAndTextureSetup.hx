package dust.graphics.colorAndTexture.data;

import dust.gui.data.Color;

class ColorAndTextureSetup
{
    public var maxVertices:Int;
    public var maxFaces:Int;
    public var background:Color;

    public function new()
    {
        maxVertices = 65535;
        maxFaces = 20000;
        background = new Color(0x000000, 1.0);
    }
}
