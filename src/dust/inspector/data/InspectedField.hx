package dust.inspector.data;

import dust.entities.Entity;

class InspectedField
{
    static var ID:Int = 0;
    public var id:Int;

    public var type:Class<Dynamic>;
    public var field:String;
    public var value:Dynamic;

    var name:String;

    public function new(type:Class<Dynamic>, field:String)
    {
        id = ++ID;
        this.type = type;
        this.field = field;
        this.name = getName();
    }

        function getName():String
        {
            var string = Std.string(type);
            return [string.substr(7, string.length - 8), field].join('.');
        }

    public function update(entity:Entity)
    {
        var property = entity.get(type);
        value = Reflect.field(property, field);
    }

    public function toString():String
        return name
}