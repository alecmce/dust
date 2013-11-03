package dust.graphics.colorAndTexture.data;

import dust.graphics.data.Vertex3D;

class ColorAndTexturePolygon
{
    public var count:Int;
    public var offsets:Array<Vertex3D>;
    public var vertices:Array<ColorAndTextureVertex>;
    public var triangles:Array<Array<Int>>;

    public function new(offsets:Array<Vertex3D>)
    {
        count = offsets.length;
        this.offsets = offsets;
        this.vertices = makeVertices();
    }

        function makeVertices():Array<ColorAndTextureVertex>
        {
            var list = new Array<ColorAndTextureVertex>();
            for (vertex in offsets)
                list.push(new ColorAndTextureVertex());
            return list;
        }

    inline public function setPosition(x:Float, y:Float, z:Float)
    {
        for (i in 0...vertices)
        {
            var offset = offsets[i];
            vertex.setPosition(x + offset.x, y + offset.y, z + offset.z);
        }

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
        for (poly)
        data[5] = r;
        data[6] = g;
        data[7] = b;
    }

    inline public function setAlpha(alpha:Float)
    {
        data[8] = alpha;
    }

}
