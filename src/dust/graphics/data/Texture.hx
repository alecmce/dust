package dust.graphics.data;

import flash.geom.Rectangle;
import flash.geom.Rectangle;

class Texture
{
    public var name:String;
    public var source:Rectangle;
    public var region:Rectangle;

    public function new(name:String, source:Rectangle, region:Rectangle)
    {
        this.name = name;
        this.source = source;
        this.region = region;
    }

    public function toString():String
    {
        var lines = new Array<String>();
        lines.push('name:$name');
        if (source != null)
            lines.push('source: [x:${source.left}, y:${source.top}, w:${source.width}, h:${source.height}]');
        if (region != null)
            lines.push('region: [x:${region.left}, y:${region.top}, w:${region.width}, h:${region.height}]');
        return '[Texture ${lines.join("\n         ")}]';
    }
}
