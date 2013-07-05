package dust.console.impl;

class ConsoleMap
{
    var hash:Map<String, ConsoleMapping>;

    public function new()
    {
        hash = new Map<String, ConsoleMapping>();
    }

    public function map(pattern:String):ConsoleMapping
    {
        return if (hash.exists(pattern))
            hash.get(pattern);
        else
            makeMapping(pattern);
    }

        function makeMapping(pattern:String):ConsoleMapping
        {
            var mapping = new ConsoleMapping(pattern);
            hash.set(pattern, mapping);
            return mapping;
        }

    public function execute(pattern:String, params:Array<String>)
    {
        if (hash.exists(pattern))
            hash.get(pattern).execute(params);
    }

    public function iterator():Iterator<ConsoleMapping>
    {
        return hash.iterator();
    }
}
