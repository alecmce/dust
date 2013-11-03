package dust.graphics.text.control;

import dust.graphics.text.data.Font;

class Fonts
{
    var cache:Map<String, Font>;

    public function new()
    {
        cache = new Map<String, Font>();
    }

    public function get(name:String):Font
    {
        return cache.get(name);
    }

    public function add(name:String, font:Font)
    {
        cache.set(name, font);
    }
}
