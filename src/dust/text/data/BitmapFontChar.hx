package dust.text.data;

import nme.display.BitmapData;

class BitmapFontChar
{
    public var id:Int;
    public var data:BitmapData;
    public var dx:Int;
    public var dy:Int;
    public var xAdvance:Int;

    var kerning:IntHash<Int>;

    public function new()
        kerning = new IntHash<Int>()

    public function addKerning(char:Int, amount:Int)
        kerning.set(char, amount)

    public function getKerning(char:Int):Int
        return kerning.exists(char) ? kerning.get(char) : 0
}
