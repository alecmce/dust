package dust.graphics.text.data;

class Font
{
    public var name:String;
    public var size:Int;
    public var bold:Bool;
    public var italic:Bool;
    public var lineHeight:Int;
    public var base:Int;

    var chars:Map<Int, Char>;

    public function new()
    {
        chars = new Map<Int, Char>();
    }

    public function addChar(char:Char)
    {
        chars.set(char.id, char);
    }

    public function getChar(id:Int):Char
    {
        return chars.get(id);
    }
}
