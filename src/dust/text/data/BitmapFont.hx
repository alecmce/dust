package dust.text.data;

class BitmapFont
{
    public var name:String;
    public var size:Int;
    public var bold:Bool;
    public var italic:Bool;
    public var lineHeight:Int;
    public var base:Int;

    var chars:IntHash<BitmapFontChar>;

    public function new()
        chars = new IntHash<BitmapFontChar>()

    public function addChar(char:BitmapFontChar)
        chars.set(char.id, char)

    public function getChar(id:Int):BitmapFontChar
        return chars.get(id)
}
