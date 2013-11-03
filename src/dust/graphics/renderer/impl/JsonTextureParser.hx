package dust.graphics.renderer.impl;

import haxe.Json;
import flash.geom.Rectangle;
import dust.graphics.data.Texture;

class JsonTextureParser
{
    var width:Int;
    var height:Int;
    var invWidth:Float;
    var invHeight:Float;
    var textures:Map<String, Texture>;

    public function new() {}

    public function parse(json:String):Map<String, Texture>
    {
        textures = new Map<String, Texture>();
        var data = Json.parse(json);
        parseScalars(data);
        parseFrames(data);
        return textures;
    }

    function parseScalars(data:Dynamic)
    {
        var meta = Reflect.field(data, "meta");
        var size = Reflect.field(meta, "size");
        invWidth = 1 / Reflect.field(size, "w");
        invHeight = 1 / Reflect.field(size, "h");
    }

    function parseFrames(data:Dynamic)
    {
        var frames = Reflect.field(data, "frames");
        for (key in Reflect.fields(frames))
        {
            textures.set(key, parseFrame(key, Reflect.field(frames, key)));
        }
    }

    function parseFrame(key:String, data:Dynamic)
    {
        var frame = Reflect.field(data, "frame");
        var x = Reflect.field(frame, "x");
        var y = Reflect.field(frame, "y");
        var w = Reflect.field(frame, "w");
        var h = Reflect.field(frame, "h");

        var source = new Rectangle(x, y, w, h);
        var region = new Rectangle(x * invWidth, y * invHeight, w * invWidth, h * invHeight);
        return new Texture(key, source, region);
    }
}
