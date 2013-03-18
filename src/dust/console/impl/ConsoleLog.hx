package dust.console.impl;

class ConsoleLog
{
    var index:Int;
    var list:Array<String>;

    public function new()
    {
        index = 0;
        list = new Array<String>();
    }

    public function log(text:String)
    {
        if (index < list.length)
            list = list.slice(0, index);
        index = list.push(text);
    }

    public function previous():String
    {
        return index > 0 ? list[--index] : "";
    }

    public function next():String
    {
        return index < list.length - 1 ? list[++index] : "";
    }
}
