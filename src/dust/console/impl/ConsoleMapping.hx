package dust.console.impl;

class ConsoleMapping
{
    var name:String;
    var description:String;
    var listeners:Array<Array<String>->Void>;

    public function new(name:String)
    {
        this.name = name;
        this.description = "<no description>";
        listeners = new Array<Array<String>->Void>();
    }

    public function toMethod(listener:Array<String>->Void):ConsoleMapping
    {
        listeners.push(listener);
        return this;
    }

    public function describe(description:String):ConsoleMapping
    {
        this.description = description;
        return this;
    }

    public function getDescription():String
    {
        return name + ": " + description;
    }

    public function execute(data:Array<String>)
    {
        for (listener in listeners)
            listener(data);
    }
}
