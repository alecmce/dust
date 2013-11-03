package dust.graphics.colorAndTexture.data;

class ColorAndTextureVertex
{
    public var data:Array<Float>;

    public function new()
    {
        data = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    }

    inline public function setPosition(x:Float, y:Float, z:Float)
    {
        data[0] = x;
        data[1] = y;
        data[2] = z;
    }

    inline public function setTexture(x:Float, y:Float)
    {
        data[3] = x;
        data[4] = y;
    }

    inline public function setColor(r:Float, g:Float, b:Float)
    {
        data[5] = r;
        data[6] = g;
        data[7] = b;
    }

    inline public function setAlpha(alpha:Float)
    {
        data[8] = alpha;
    }

}
