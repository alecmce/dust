package dust.graphics.text.control;

import dust.graphics.text.data.FontDefinitionData;
import flash.geom.Rectangle;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import dust.graphics.control.XYPlaneSurfaceFactory;
import dust.graphics.data.Texture;
import dust.graphics.text.data.Char;

class CharFactory
{
    @inject public var surface:XYPlaneSurfaceFactory;

    private var origin:Point;
    private var rect:Rectangle;
    private var pixel:BitmapData;

    var data:FontDefinitionData;
    var source:Texture;

    public function new()
    {
        origin = new Point();
        rect = new Rectangle();
        pixel = new BitmapData(1, 1, true, 0);
    }

    public function make(key:String, data:FontDefinitionData, source:Texture, padding:Float):Char
    {
        this.data = data;
        this.source = source;

        var bounds = new Rectangle(data.getInt('x'), data.getInt('y'), data.getInt('width'), data.getInt('height'));
        bounds.inflate(padding, padding);

        var char:Char = new Char();
        char.id = data.getInt('id');
        char.dx = data.getInt('xoffset');
        char.dy = data.getInt('yoffset');
        char.advance = data.getInt('xadvance');
        char.bounds = bounds;
        char.texture = makeTexture(key, bounds);
        return char;
    }

        function makeTexture(key:String, bounds:Rectangle):Texture
        {
            var dx = source.source.x;
            var dy = source.source.y;
            var sx = source.region.width / source.source.width;
            var sy = source.region.height / source.source.height;

            var source = bounds.clone();
            source.offset(dx, dy);

            var region = new Rectangle(source.x * sx, source.y * sy, source.width * sx, source.height * sy);

            return new Texture(key, source, region);
        }

}
