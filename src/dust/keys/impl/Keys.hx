package dust.keys.impl;

class Keys
{
    var map:Array<Bool>;

    public function new()
    {
        map = new Array<Bool>();
    }

    public function reset()
    {
        for (i in 0...255)
            map[i] = false;
    }

    inline public function setKeyDown(key:Int)
    {
        map[key] = true;
    }

    inline public function setKeyUp(key:Int)
    {
        map[key] = false;
    }

    inline public function isDown(key:Int):Bool
    {
        return map[key];
    }
}
