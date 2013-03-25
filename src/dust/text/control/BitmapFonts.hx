package dust.text.control;

import dust.text.data.BitmapFont;

class BitmapFonts
{
    var cache:Hash<BitmapFont>;

    public function new()
        cache = new Hash<BitmapFont>()

    public function get(name:String):BitmapFont
        return cache.get(name)

    public function add(name:String, font:BitmapFont)
        cache.set(name, font)
}
