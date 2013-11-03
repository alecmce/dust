package dust.graphics.text.data;

import flash.geom.Rectangle;
import dust.graphics.data.Texture;
import flash.geom.Point;

class Char
{
    static var position:Point = new Point();

    public var id:Int;
    public var dx:Int;
    public var dy:Int;
    public var bounds:Rectangle;
    public var advance:Int;
    public var texture:Texture;

    var kerning:Map<Int, Int>;

    public function new()
    {
        kerning = new Map<Int, Int>();
    }

    public function addKerning(char:Int, amount:Int)
    {
        kerning.set(char, amount);
    }

    public function getKerning(char:Int):Int
    {
        return kerning.exists(char) ? kerning.get(char) : 0;
    }

    public function toString():String
    {
        return '[FontChar char: ${String.fromCharCode(id)} id: $id dx: $dx dy: $dy advance: $advance]';
    }
}
