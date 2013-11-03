package dust.graphics.text.data;

class FontDefinitionData
{
    public var name:String;
    public var map:Map<String, String>;

    public function new(name:String)
    {
        this.name = name;
        this.map = new Map<String, String>();
    }

    public function define(key:String, value:String)
    {
        map.set(key, value);
    }

    public function getString(key:String):String
    {
        return map.get(key);
    }

    public function getInt(key:String):Int
    {
        return Std.parseInt(map.get(key));
    }

    public function getBool(key:String):Bool
    {
        return Std.parseInt(map.get(key)) != 0;
    }
}